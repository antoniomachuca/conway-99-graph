import Conway.Z7GenSplit
import Conway.Z7UnaryCode
open Matrix99

-- Emit Z7UnaryCode{i}.lean and Z7UnaryCache{i}.lean for given index/depth.

def fmtNatList (l : List Nat) : String :=
  "[" ++ String.intercalate ", " (l.map toString) ++ "]"

def fmtRow (r : List Nat) : String := fmtNatList r

def fmtInt (b : Int) : String :=
  if b < 0 then s!"({b} : Int)" else s!"({b} : Int)"

def fmtState (s : List Nat × Nat × Nat × Int) : String :=
  s!"({fmtRow s.1}, {s.2.1}, {s.2.2.1}, {fmtInt s.2.2.2})"

def chunkedLit (name : String) (elems : List Nat) : String :=
  if elems.length ≤ 1000 then
    s!"def {name} : List Nat := {fmtNatList elems}\n"
  else
    let chunks := Id.run do
      let mut acc : Array (List Nat) := #[]
      let mut cur : List Nat := []
      let mut n := 0
      for e in elems do
        if cur.length ≥ 1000 then
          acc := acc.push cur.reverse
          cur := []
        cur := e :: cur
        n := n + 1
      if cur.length > 0 then acc := acc.push cur.reverse
      acc
    let parts := chunks.toList.zipIdx.map fun (c, k) =>
      s!"private def {name}_c{k} : List Nat := {fmtNatList c}\n"
    let rhs := String.intercalate " ++ " (chunks.toList.zipIdx.map fun (_, k) => s!"{name}_c{k}")
    String.join parts ++ s!"def {name} : List Nat := {rhs}\n"

def joinR : List String → String
  | [] => "[]"
  | [x] => x
  | x :: xs => x ++ " ++ (" ++ joinR xs ++ ")"

def emitIndex (i D : Nat) (dir : System.FilePath) : IO Unit := do
  let fi : Fin 12 := if h : i < 12 then ⟨i, h⟩ else ⟨0, by decide⟩
  let states := z7GenStates D 12 i 0 [] 12 (z7ExteriorTarget fi fi) 0
  let nstates := states.length
  -- per-state slices
  let mut codeParts : Array String := #[]
  let mut cacheParts : Array String := #[]
  let mut sliceNames : List String := []
  for (s, k) in states.zipIdx do
    let rows := z7GenRow (12 - D) i D s.1 s.2.1 s.2.2.1 s.2.2.2
    let enc := rows.map z7EncodeRow
    let name := s!"z7UnaryCode{i}_s{k}"
    codeParts := codeParts.push (chunkedLit name enc)
    sliceNames := sliceNames ++ [name]
    cacheParts := cacheParts.push s!"theorem z7UnaryRows{i}_s{k} : rowsBeq\n    (z7GenRow {12 - D} {i} {D} {fmtRow s.1} {s.2.1} {s.2.2.1} {fmtInt s.2.2.2})\n    ({name}.map z7DecodeRow) = true := by\n  decide +kernel\n\ntheorem z7UnaryRows{i}_s{k}_eq :\n    z7GenRow (12 - {D}) ({i} : Fin 12).val (0 + {D}) {fmtState s}.1 {fmtState s}.2.1\n      {fmtState s}.2.2.1 {fmtState s}.2.2.2 =\n    {name}.map z7DecodeRow := by\n  show z7GenRow {12 - D} {i} {D} {fmtRow s.1} {s.2.1} {s.2.2.1} {fmtInt s.2.2.2} = _\n  exact rowsBeq_sound z7UnaryRows{i}_s{k}\n"
  -- code file
  let codeRhs := joinR sliceNames
  let codeFile :=
    s!"import Conway.Z7UnaryCode\nnamespace Matrix99\n\nset_option maxRecDepth 100000\n\n" ++
    String.join codeParts.toList ++
    s!"\n/-- Encoded unary rows for index {i}, in z7UnaryRows generation order. -/\ndef z7UnaryCode{i} : List Nat := {codeRhs}\n\nend Matrix99\n"
  -- two-level grouped assembly: groups of <=16 states
  let statesArr := states.zipIdx
  let groupSize := 16
  let mut groupLits : Array String := #[]
  let mut groupThms : Array String := #[]
  let mut j := 0
  while j * groupSize < states.length do
    let grp := statesArr.drop (j * groupSize) |>.take groupSize
    let grpLit := "[" ++ String.intercalate ", " (grp.map fun (s, _) => fmtState s) ++ "]"
    groupLits := groupLits.push grpLit
    let sliceMaps := joinR (grp.map fun (_, k) => s!"z7UnaryCode{i}_s{k}.map z7DecodeRow")
    let mut prf := ""
    for (_, k) in grp do
      prf := prf ++ s!"  rw [List.flatMap_cons, z7UnaryRows{i}_s{k}_eq]\n"
    prf := prf ++ "  rw [List.flatMap_nil, List.append_nil]\n"
    groupThms := groupThms.push
      s!"/-- flatMap of state group {j} equals the joined decoded slices. -/\ntheorem z7Grp_{i}_{j} :\n    ({grpLit}).flatMap (fun s => z7GenRow (12 - {D}) ({i} : Fin 12).val (0 + {D}) s.1 s.2.1 s.2.2.1 s.2.2.2)\n      = {sliceMaps} := by\n{prf}"
    j := j + 1
  let groupJoin := joinR groupLits.toList
  let grpRw := String.intercalate ", " ((List.range groupLits.size).map fun jj => s!"z7Grp_{i}_{jj}")
  let statesLit := "[" ++ String.intercalate ", " (states.map fmtState) ++ "]"
  let cacheFile :=
    s!"import Conway.Z7GenSplit\nimport Conway.Z7UnaryCode{i}\nnamespace Matrix99\n\nset_option maxHeartbeats 800000000\nset_option maxRecDepth 100000\nset_option Elab.async false\n\n" ++
    s!"/-- Reached depth-{D} generator states for index {i}. -/\ntheorem states_{i} : z7GenStates {D} 12 ({i} : Fin 12).val 0 [] 12\n    (z7ExteriorTarget {i} {i}) 0 = {statesLit} := by\n  decide +kernel\n\n" ++
    String.join cacheParts.toList ++ "\n" ++ String.join groupThms.toList ++
    s!"\ntheorem z7UnaryRows_cached_{i} : z7UnaryRows {i} = z7UnaryCode{i}.map z7DecodeRow := by\n  unfold z7UnaryRows z7UnaryCode{i}\n  rw [z7GenRow_split {D} 12 ({i} : Fin 12).val 0 [] 12\n      (z7ExteriorTarget {i} {i}) 0 (by decide) (by decide)]\n  rw [states_{i}]\n  rw [show {statesLit} = {groupJoin} from rfl]\n  repeat rw [List.flatMap_append]\n  rw [{grpRw}]\n  repeat rw [List.map_append]\n  repeat rw [← List.append_assoc]\n" ++
    "\n#print axioms z7UnaryRows_cached_" ++ toString i ++ "\n\nend Matrix99\n"
  IO.FS.writeFile (dir / s!"Z7UnaryCode{i}.lean") codeFile
  IO.FS.writeFile (dir / s!"Z7UnaryCache{i}.lean") cacheFile
  IO.println s!"index {i}: {nstates} states; slice lengths: {String.intercalate "," (states.map fun s => toString (z7GenRow (12-D) i D s.1 s.2.1 s.2.2.1 s.2.2.2).length)}"

def main (args : List String) : IO Unit := do
  match args with
  | [is, ds, dir] =>
    let i := is.toNat!
    let D := ds.toNat!
    emitIndex i D ⟨dir⟩
  | _ => IO.eprintln "usage: gen_slices <i> <D> <dir>"
