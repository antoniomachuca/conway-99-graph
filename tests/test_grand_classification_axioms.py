#!/usr/bin/env python3
"""tests/test_grand_classification_axioms.py

Forensic Kernel Axiom and Four-State Taxonomy Audit for Conway.GrandClassification.
Verifies:
1. All 11 deduction lemmas and grand classification theorems compile under Lean 4.33.1.
2. Kernel axioms for each declaration are inspected via `lake env lean`.
3. Strict four-state classification:
   - PROVED: conway_no_z7_deduction, conway_no_order_14_deduction,
             conway_no_order_14_analytical_trace_deduction, conway_no_frob21_orbit_row4_deduction,
             conway_divisible_by_7_excluded, conway_parity_rigidity_deduction,
             conway_no_order_4_group_deduction, conway_no_dihedral_group_deduction,
             conway_automorphism_group_trivial_conditional.
             Axioms strictly subset of [propext, Quot.sound], 0 sorry, 0 sorryAx, 0 Classical.choice.
   - COMPILED: conway_no_z3_fixed3_deduction, conway_no_z3_fpf_deduction,
               conway_no_z3_classified_deduction, conway_automorphism_group_restricted,
               conway_automorphism_group_trivial.
               Transitively depends on sorryAx (via Z3 and Z2 reflection gaps).
4. No Classical.choice in any audited declaration.
5. Radical honesty: confirms that conway_automorphism_group_trivial is COMPILED (not PROVED).
"""

import subprocess
import re
from pathlib import Path
import pytest

REPO_ROOT = Path(__file__).resolve().parents[1]
GRAND_LEAN = REPO_ROOT / "Conway" / "GrandClassification.lean"


def get_lean_axioms():
    """Runs `lake env lean Conway/GrandClassification.lean` and parses #print axioms."""
    cmd = ["lake", "env", "lean", str(GRAND_LEAN)]
    result = subprocess.run(cmd, cwd=REPO_ROOT, capture_output=True, text=True)
    assert result.returncode == 0, f"Lean compilation failed with error:\n{result.stderr}"

    # Parse output: 'Matrix99.<decl>' depends on axioms: [<axioms>]
    pattern = re.compile(r"'Matrix99\.([A-Za-z0-9_]+)'\s+depends on axioms:\s*\[(.*?)\]", re.DOTALL)
    axioms_map = {}
    for match in pattern.finditer(result.stdout):
        decl_name = match.group(1)
        raw_axioms = [a.strip() for a in match.group(2).replace("\n", " ").split(",") if a.strip()]
        axioms_map[decl_name] = raw_axioms
    return axioms_map


class TestGrandClassificationKernelAxioms:
    """Forensic verification of Lean 4 kernel axioms for GrandClassification."""

    @classmethod
    def setup_class(cls):
        cls.axioms = get_lean_axioms()

    def test_all_declarations_present_in_kernel_output(self):
        expected_decls = [
            "conway_no_z2_deduction",
            "conway_no_z7_deduction",
            "conway_no_z3_fixed3_deduction",
            "conway_no_z3_fpf_deduction",
            "conway_no_z3_classified_deduction",
            "conway_no_order_14_deduction",
            "conway_no_order_14_analytical_trace_deduction",
            "conway_no_frob21_orbit_row4_deduction",
            "conway_divisible_by_7_excluded",
            "conway_parity_rigidity_deduction",
            "conway_no_order_4_group_deduction",
            "conway_no_dihedral_group_deduction",
            "conway_automorphism_group_restricted",
            "conway_automorphism_group_trivial_conditional",
            "conway_no_nontrivial_automorphism_of_prime_order_element",
            "conway_automorphism_group_trivial_of_certificates",
            "conway_automorphism_group_trivial",
        ]
        for decl in expected_decls:
            assert decl in self.axioms, f"Missing kernel axiom output for {decl}"

    def test_proved_theorems_foundation_policy(self):
        """Theorems with status PROVED must depend strictly on standard foundations."""
        proved_decls = [
            "conway_no_z7_deduction",
            "conway_no_order_14_deduction",
            "conway_no_order_14_analytical_trace_deduction",
            "conway_no_frob21_orbit_row4_deduction",
            "conway_divisible_by_7_excluded",
            "conway_parity_rigidity_deduction",
            "conway_no_order_4_group_deduction",
            "conway_no_dihedral_group_deduction",
            "conway_automorphism_group_trivial_conditional",
            "conway_no_nontrivial_automorphism_of_prime_order_element",
            "conway_automorphism_group_trivial_of_certificates",
        ]
        standard_foundations = {"propext", "Quot.sound"}
        for decl in proved_decls:
            ax = set(self.axioms[decl])
            assert ax.issubset(standard_foundations), (
                f"{decl} violates standard foundation policy: {ax}"
            )
            assert "sorryAx" not in ax, f"{decl} contains sorryAx but was claimed PROVED"
            assert "Classical.choice" not in ax, f"{decl} contains Classical.choice"

    def test_compiled_theorems_honest_sorryax_accounting(self):
        """Theorems with status COMPILED must honestly declare transitive sorryAx or uncertified axioms."""
        compiled_decls = [
            "conway_no_z2_deduction",
            "conway_no_z3_fixed3_deduction",
            "conway_no_z3_fpf_deduction",
            "conway_no_z3_classified_deduction",
            "conway_automorphism_group_restricted",
            "conway_automorphism_group_trivial",
        ]
        for decl in compiled_decls:
            ax = self.axioms[decl]
            assert (
                "sorryAx" in ax
                or "djematene_discriminant_obstruction" in ax
                or "z3_fixed3_orbit_matrix_certificate_obstruction" in ax
                or "conway_no_z2_certificate_obstruction" in ax
            ), (
                f"{decl} has neither sorryAx nor uncertified axioms: check if Z3/Z2 was unexpectedly closed"
            )

    def test_zero_classical_choice_globally(self):
        """No declaration in GrandClassification should pull in Classical.choice."""
        for decl, ax in self.axioms.items():
            assert "Classical.choice" not in ax, (
                f"Declaration {decl} taints kernel with Classical.choice: {ax}"
            )
