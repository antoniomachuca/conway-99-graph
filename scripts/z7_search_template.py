#!/usr/bin/env python3
"""Emit Conway/Z7Root{NN}Search.lean: the split-search template.

render_search(curr_num, dom_text, chunk) returns the file contents.
dom_text is the text of Conway/Z7Root{NN}Domains.lean; L (the length of
z7Root{NN}Dom1) is recovered by parsing its literal with ast.literal_eval.
"""
import ast
import re
import sys


def _dom1_length(dom_text: str, curr_num: str) -> int:
    m = re.search(
        r"def z7Root%sDom1\s*:\s*Domain\s*:=\s*\n?\s*(\[.*?\])\n" % curr_num,
        dom_text,
        re.S,
    )
    if m is None:
        raise ValueError("z7Root%sDom1 literal not found" % curr_num)
    return len(ast.literal_eval(m.group(1)))


def render_search(curr_num: str, dom_text: str, chunk: int) -> str:
    L = _dom1_length(dom_text, curr_num)
    n = curr_num  # e.g. "08"
    bounds = []
    lo = 0
    while lo < L:
        hi = min(lo + chunk, L)
        bounds.append((lo, hi))
        lo = hi

    lines = []
    lines.append("import Conway.Z7SearchSplit")
    lines.append("import Conway.Z7Root%s" % n)
    lines.append("import Conway.Z7Root%sDomains" % n)
    for i in range(1, 12):
        lines.append("import Conway.Z7Root%sDomain%d" % (n, i))
    lines.append("")
    lines.append("namespace Matrix99")
    lines.append("")
    lines.append("theorem z7Root%sDoms_literals :" % n)
    domlist = ", ".join("z7Root%sDom%d" % (n, i) for i in range(1, 12))
    lines.append("    pinnedDoms z7Root%sRow = [%s] := by" % (n, domlist))
    lines.append("  rw [pinnedDoms, pinnedTail]")
    lines.append("  dsimp only [List.map]")
    eqls = ", ".join("z7Root%sDomain_eq_%d" % (n, i) for i in range(1, 12))
    lines.append("  rw [%s]" % eqls)
    lines.append("")
    lines.append("def z7Root%sBranch (k : Nat) : Bool :=" % n)
    lines.append("  noExtension [2, 3, 4, 5, 6, 7, 8, 9, 10, 11]")
    lines.append(
        "    (List.zipWith (fun j dom => prune 1 (z7Root%sDom1.getD k []) j dom)" % n
    )
    lines.append("      [2, 3, 4, 5, 6, 7, 8, 9, 10, 11]")
    tail = ", ".join("z7Root%sDom%d" % (n, i) for i in range(2, 12))
    lines.append("      [%s])" % tail)
    lines.append("")
    lines.append("set_option maxHeartbeats 800000000")
    lines.append("set_option maxRecDepth 10000")
    lines.append("set_option Elab.async false")
    lines.append("")
    lines.append(
        "theorem z7Root%sDom1_length : z7Root%sDom1.length = %d := by"
        % (n, n, L)
    )
    lines.append("  decide +kernel")
    lines.append("")
    for c, (lo, hi) in enumerate(bounds):
        lines.append(
            "theorem z7Root%s_chunk_%d :\n"
            "    ∀ k, k < %d → %d ≤ k → z7Root%sBranch k = true := by"
            % (n, c, hi, lo, n)
        )
        lines.append("  decide +kernel")
        lines.append("")
    lines.append(
        "theorem z7Root%s_noExtension :\n"
        "    noExtension pinnedTail (pinnedDoms z7Root%sRow) = true := by" % (n, n)
    )
    lines.append("  rw [z7Root%sDoms_literals]" % n)
    lines.append("  unfold pinnedTail")
    lines.append("  rw [noExtension_cons_cons]")
    lines.append("  apply all_of_getD _ _ []")
    lines.append("  intro k hk")
    lines.append("  rw [z7Root%sDom1_length] at hk" % n)
    lines.append("  show z7Root%sBranch k = true" % n)
    # nested if-then-else over the chunks
    parts = []
    for c, (lo, hi) in enumerate(bounds):
        parts.append(
            "if h%d : k < %d then z7Root%s_chunk_%d k h%d (by omega) else "
            % (c, hi, n, c, c)
        )
    chain = "".join(parts) + "absurd hk (by omega)"
    lines.append("  exact " + chain)
    lines.append("")
    lines.append("#print axioms z7Root%sDoms_literals" % n)
    lines.append("#print axioms z7Root%s_noExtension" % n)
    lines.append("")
    lines.append("end Matrix99")
    return "\n".join(lines) + "\n"

