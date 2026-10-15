#!/usr/bin/env python3
"""Graph-level SAT model for an srg(2m + 1, k, lam, mu) admitting an automorphism
sigma of order 2 fixing exactly one vertex (vertex 0).  EXPLORED tooling:
results are not certificates until checked by drat-trim.

Vertices: 0 and (i, c) for i = 1..m, c in {0, 1}, with sigma(i, c) = (i, 1 - c).
Adjacency is sigma-invariant, so it is given by the orbit data
  f(i)     <=> 0 ~ (i, c)                    (same for both c)
  e(i)     <=> (i, 0) ~ (i, 1)
  x(i,j,s) <=> (i, c) ~ (j, c + s mod 2)     (i < j, s in {0,1}; same for both c)
The srg equation A^2 + (mu - lam) A - (k - mu) I = mu J is enforced on one
representative of each sigma-orbit of vertex pairs; the partner equation follows
by applying sigma.  Degree equations on u = 0 and u = (i, 0).

Optional --phi h adds Djematene-style eigenfunction constraints for a
{0, +/-1}-valued phi with phi o sigma = -phi, A phi = -4 phi, sum phi^2 = 2h,
normalized (relabel orbits, swap inside pairs) to
  phi = +1 on {(i,0): i <= h}, -1 on {(i,1): i <= h}, 0 elsewhere.
Then A phi(u) = -4 phi(u) becomes D(u) = -4 phi(u) where
  D(u) = #neighbours of u in S+ - #neighbours of u in S-,
encoded for u = (i, 0) as one cardinality constraint
  sum_{j <= h} L((i,0),(j,0)) + sum_{j <= h} ~L((i,0),(j,1)) = h + D_target(i)
(the (i,1) conditions follow by sigma; at vertex 0 it is automatic since
phi o sigma = -phi forces neighbours of 0 to come in sigma pairs).
"""
import argparse
import itertools
import json
import sys
import time

from pysat.card import CardEnc, EncType
from pysat.formula import IDPool
from pysat.solvers import Solver

TRUE, FALSE = "T", "F"


class Model:
    def __init__(self, m, k, lam, mu, phi=None):
        self.m, self.k, self.lam, self.mu = m, k, lam, mu
        self.pool = IDPool()
        self.clauses = []
        self.build()
        if phi is not None:
            self.phi(phi)

    # ----- variable / literal access --------------------------------------
    def f(self, i):
        return self.pool.id(("f", i))

    def e(self, i):
        return self.pool.id(("e", i))

    def x(self, i, j, s):
        return self.pool.id(("x", i, j, s))

    def L(self, u, v):
        """Adjacency literal; u, v are 0 or (i, c) with 1 <= i <= m, c in {0,1}."""
        if u == v:
            return FALSE
        if u == 0:
            return self.f(v[0])
        if v == 0:
            return self.f(u[0])
        i, c = u
        j, c2 = v
        if i == j:
            return self.e(i)
        if i < j:
            return self.x(i, j, (c2 - c) % 2)
        return self.x(j, i, (c - c2) % 2)

    def vertices(self):
        return [0] + [(i, c) for i in range(1, self.m + 1) for c in (0, 1)]

    # ----- encodings --------------------------------------------------------
    def AND(self, a, b):
        if a == FALSE or b == FALSE:
            return FALSE
        if a == b:
            return a
        a, b = min(a, b), max(a, b)
        key = ("and", a, b)
        new = key not in self.pool.obj2id
        p = self.pool.id(key)
        if new:
            self.clauses += [[-p, a], [-p, b], [p, -a, -b]]
        return p

    def exactly(self, units, bound):
        if bound > len(units) or bound < 0:
            self.clauses.append([])
            return
        if not units:
            return
        enc = CardEnc.equals(lits=units, bound=bound, vpool=self.pool, encoding=EncType.seqcounter)
        self.clauses += enc.clauses

    def card_atmost(self, lits, bound):
        self.clauses += CardEnc.atmost(lits=lits, bound=bound, vpool=self.pool, encoding=EncType.seqcounter).clauses

    def copies(self, l):
        """mu - lam copies of l as list members (copy vars when mu - lam > 1)."""
        out = []
        for c in range(self.mu - self.lam):
            q = self.pool.id(("copy", l, c))
            self.clauses += [[-q, l], [q, -l]]
            out.append(q)
        return out

    def pair_eq(self, u, v):
        """sum_w AND(L(u,w), L(w,v)) + (mu - lam) L(u,v) = mu."""
        units = []
        for w in self.vertices():
            p = self.AND(self.L(u, w), self.L(w, v))
            if p != FALSE:
                units.append(p)
        luv = self.L(u, v)
        if luv != FALSE:
            units += self.copies(luv)
        self.exactly(units, self.mu)

    def build(self):
        m, k, mu = self.m, self.k, self.mu
        # degree of vertex 0: 2 * sum_i f(i) = k
        if k % 2:
            self.clauses.append([])
            return
        self.exactly([self.f(i) for i in range(1, m + 1)], k // 2)
        for i in range(1, m + 1):
            u = (i, 0)
            # degree of (i, 0)
            self.exactly([self.L(u, w) for w in self.vertices() if w != u], k)
            # pair equations, one rep per sigma-orbit of pairs
            self.pair_eq(0, u)                     # {0, (i,0)} ~ {0, (i,1)}
            self.pair_eq(u, (i, 1))                # {(i,0), (i,1)} (sigma-invariant pair)
        for i in range(1, m + 1):
            for j in range(i + 1, m + 1):
                for s in (0, 1):
                    self.pair_eq((i, 0), (j, s))   # reps ((i,0),(j,0)) and ((i,0),(j,1))

    # ----- eigenfunction constraint ----------------------------------------
    def phi(self, h):
        """A phi = -4 phi for phi = +1_{S+} - 1_{S-}, S+ = {(i,0): i <= h}.
        For u = (i,0):  sum_{j<=h} L(u,(j,0)) + sum_{j<=h} ~L(u,(j,1)) = h + Dt,
        Dt = -4 if i <= h else 0.  Constant-false terms L(u,u) are dropped."""
        m = self.m
        assert 0 <= h <= m
        for i in range(1, m + 1):
            u = (i, 0)
            lits = []
            for j in range(1, h + 1):
                a = self.L(u, (j, 0))
                if a != FALSE:
                    lits.append(a)
                b = self.L(u, (j, 1))
                if b != FALSE:
                    lits.append(-b)
            self.exactly(lits, h + (-4 if i <= h else 0))

    # ----- decode ------------------------------------------------------------
    def decode(self, model):
        """Adjacency list on vertex ids: 0 -> 0, (i, c) -> 1 + 2*(i-1) + c."""
        pos = {v for v in model if v > 0}
        m = self.m
        n = 2 * m + 1
        adj = [set() for _ in range(n)]

        def vid(u):
            return 0 if u == 0 else 1 + 2 * (u[0] - 1) + u[1]

        def on(l):
            return False if l == FALSE else (l in pos)

        for i in range(1, m + 1):
            if on(self.f(i)):
                for c in (0, 1):
                    adj[0].add(vid((i, c)))
                    adj[vid((i, c))].add(0)
            if on(self.e(i)):
                adj[vid((i, 0))].add(vid((i, 1)))
                adj[vid((i, 1))].add(vid((i, 0)))
            for j in range(i + 1, m + 1):
                for s in (0, 1):
                    if on(self.x(i, j, s)):
                        for c in (0, 1):
                            a, b = vid((i, c)), vid((j, (c + s) % 2))
                            adj[a].add(b)
                            adj[b].add(a)
        return adj


def srg_check(adj, k, lam, mu):
    n = len(adj)
    for u in range(n):
        if u in adj[u] or len(adj[u]) != k:
            return False
        for v in adj[u]:
            if u not in adj[v]:
                return False
    for u, v in itertools.combinations(range(n), 2):
        c = len(adj[u] & adj[v])
        if c != (lam if v in adj[u] else mu):
            return False
    return True


def sigma_check(adj):
    """sigma: 0 -> 0, (i,c) -> (i,1-c) is an automorphism with exactly one fixed point."""
    n = len(adj)
    m = (n - 1) // 2

    def sig(u):
        return 0 if u == 0 else (1 + 2 * ((u - 1) // 2) + (1 - (u - 1) % 2))

    for u in range(n):
        if sig(sig(u)) != u:
            return False
        for v in adj[u]:
            if sig(v) not in adj[sig(u)]:
                return False
    return sum(sig(u) == u for u in range(n)) == 1


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--m", type=int, required=True)
    ap.add_argument("--k", type=int, required=True)
    ap.add_argument("--lam", type=int, required=True)
    ap.add_argument("--mu", type=int, required=True)
    ap.add_argument("--phi", type=int, help="eigenfunction: +1 on {(i,0): i<=h}, -1 on sigma images, A phi = -4 phi")
    ap.add_argument("--seconds", type=float, default=60)
    ap.add_argument("--solver", default="cadical195")
    ap.add_argument("--dimacs", type=str, help="also write the CNF here")
    ap.add_argument("--no-solve", action="store_true", dest="no_solve")
    args = ap.parse_args()
    t0 = time.time()
    M = Model(args.m, args.k, args.lam, args.mu, phi=args.phi)
    info = {"m": args.m, "k": args.k, "lam": args.lam, "mu": args.mu, "phi": args.phi,
            "vars": M.pool.top, "clauses": len(M.clauses), "build_s": round(time.time() - t0, 1)}
    if args.dimacs:
        with open(args.dimacs, "w") as fo:
            fo.write(f"p cnf {M.pool.top} {len(M.clauses)}\n")
            for cl in M.clauses:
                fo.write(" ".join(map(str, cl)) + " 0\n")
    if args.no_solve:
        print(json.dumps(info))
        return
    with Solver(name=args.solver, bootstrap_with=M.clauses) as S:
        t1 = time.time()
        res = None
        while time.time() - t1 < args.seconds:
            S.conf_budget(20000)
            res = S.solve_limited()
            if res is not None:
                break
        info["conflicts"] = S.accum_stats().get("conflicts")
        info["solve_s"] = round(time.time() - t1, 1)
        info["result"] = {True: "SAT", False: "UNSAT", None: "UNKNOWN"}[res]
        if res:
            adj = M.decode(S.get_model())
            info["srg_check"] = srg_check(adj, args.k, args.lam, args.mu)
            info["sigma_check"] = sigma_check(adj)
    print(json.dumps(info))


if __name__ == "__main__":
    sys.exit(main())
