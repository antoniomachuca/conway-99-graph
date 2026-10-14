import Conway.Z3FpfCNFT27

/-!
# DIMACS exporter for the t = 27 group-ring CNFs (WP7)

Writes `B6.cnf B7.cnf B8.cnf B9.cnf B11.cnf S10.cnf` to the directory given
as the first command-line argument, serialized exactly from
`CnfT27.cnfB n` / `CnfT27.cnfS10` via `ConwayCNF.toDimacs`.
-/

open Matrix99.Z3FpfGroupRing.CnfT27 ConwayCNF

def outFiles : List (String × (Nat × CNF)) :=
  [("B6.cnf", cnfB 6), ("B7.cnf", cnfB 7), ("B8.cnf", cnfB 8),
   ("B9.cnf", cnfB 9), ("B11.cnf", cnfB 11), ("S10.cnf", cnfS10)]

def main (args : List String) : IO Unit := do
  let dir := args.head?.getD "."
  for (name, ⟨nvars, F⟩) in outFiles do
    let path := dir ++ "/" ++ name
    IO.FS.writeFile path (toDimacs nvars F)
    IO.println s!"wrote {path}  p cnf {nvars} {F.length}"
