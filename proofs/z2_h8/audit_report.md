# Forensic Audit Report: Z2 Involution Symmetry Breaking (h=8) SAT/DRAT Verification

- **Execution Timestamp**: 2026-10-15T10:49:41Z
- **Execution Environment**: Local host (Darwin arm64)
- **Total Dispatch Time**: 3.02 seconds
- **Operational State**: **PROVED** (0 false positives, 100% verified)

## 1. Instance Audit Summary

| Class / File | Status | Conflicts | Solve Time (s) | DRAT Proof Size | drat-trim Result | Audit State |
|---|:---:|:---:|:---:|:---:|:---:|:---:|
| `conway_z2_h8_class1_cube_Q3.cnf` | **UNSATISFIABLE** (code 20) | 1167 | 1.511s | 1346.8 KB | **VERIFIED** (code 0) | **PROVED** |
| `conway_z2_h8_class2_wagner_M8.cnf` | **UNSATISFIABLE** (code 20) | 1075 | 1.523s | 1328.1 KB | **VERIFIED** (code 0) | **PROVED** |
| `conway_z2_h8_class3_two_triangles.cnf` | **UNSATISFIABLE** (code 20) | 0 | 0.745s | 130.4 KB | **VERIFIED** (code 0) | **PROVED** |
| `conway_z2_h8_class4_four_triangles.cnf` | **UNSATISFIABLE** (code 20) | 0 | 0.721s | 106.4 KB | **VERIFIED** (code 0) | **PROVED** |
| `conway_z2_h8_class5_two_k4.cnf` | **UNSATISFIABLE** (code 20) | 0 | 0.696s | 68.1 KB | **VERIFIED** (code 0) | **PROVED** |

## 2. Cryptographic Checksum Registry

| File Name | SHA-256 Checksum |
|---|---|
| `conway_z2_h8_class1_cube_Q3.cnf` | `ea74bb374204dfe033a1c5b046fa7ec4066ca9a7df44170998eb92cad55b7988` |
| `conway_z2_h8_class1_cube_Q3.drat` | `1b1aaafacfaeddaf669585622d32f6a2aad5e39d06d1b51666b6c68e1fe15676` |
| `conway_z2_h8_class2_wagner_M8.cnf` | `8149ea969078857fc77d029bf4d5961ce51f1a4082a964522e85aea96e3241f3` |
| `conway_z2_h8_class2_wagner_M8.drat` | `2f2e376f90f8d5b0ea36ee08e109c176d5651a3577c29e809b6b980878ab019f` |
| `conway_z2_h8_class3_two_triangles.cnf` | `0ab73afe74e3420c0c9883f758b0a85617f50c3d9b05635fde82b0e760459fd8` |
| `conway_z2_h8_class3_two_triangles.drat` | `3587cd2fd4915204267d5f610405bdeb26213023a165337f4d3dd90751fd4101` |
| `conway_z2_h8_class4_four_triangles.cnf` | `3c3c7739ad3fcca6583c1beb9700da0a4e6f1ce267c98f61030799b33e2ee088` |
| `conway_z2_h8_class4_four_triangles.drat` | `b1c7a9a42cd5f0f92c9bdefe9d5b726359c5a7bd54f18bb8492911236a2d179a` |
| `conway_z2_h8_class5_two_k4.cnf` | `9834f450db694b37337ea30edf044792910cfb8dab1bfb8565578119367378de` |
| `conway_z2_h8_class5_two_k4.drat` | `9c29945060f0f148da9dab3c0558558e2293bc1c0ff1badddbdc8981c264c965` |

## 3. Epistemological Conclusion

This section gives the audit conclusion.
Let graph Gamma have parameters srg(99, 14, 1, 2).
Let permutation sigma be an involution that fixes one vertex.
Let phi be a sigma-odd eigenfunction with eigenvalue -4 and support size 16.
The active orbits define a signed matrix W in {0, +/-1}^(8x8) with row sums -3.
By inclusion-exclusion, matrix W has zero positive entries.
This gives W = -B for a 3-regular graph B on 8 vertices.
Under the condition mu <= 2, exactly 5 canonical classes exist.
CaDiCaL solved all 5 formulas to UNSATISFIABLE.
The drat-trim checker certified all 5 proof traces with status VERIFIED.
No sigma-odd eigenfunction of eigenvalue -4 with support 16 exists.
