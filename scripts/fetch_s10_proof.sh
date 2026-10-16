#!/usr/bin/env bash
# scripts/fetch_s10_proof.sh
# Automated fetch and verification tool for S10.drat / S10.drat.zst.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
PROOF_DIR="${REPO_ROOT}/proofs/z3_fpf_t27"
TARGET_ZST="${PROOF_DIR}/S10.drat.zst"
TARGET_DRAT="${PROOF_DIR}/S10.drat"

EXPECTED_ZST_SHA="e1238865a19eb535bd7090252277a1e8951a5fc11c4edb467090e2f04b716653"
EXPECTED_DRAT_SHA="1917bb1c592206fad045a2ed67bbdda57a009857788b0451acec6ceb55d56382"

REMOTE_HOST="antoniomachuca@100.124.116.26"
REMOTE_PATH="/home/antoniomachuca/conway_kit/z3_s10/S10.drat.zst"

echo "=== S10.drat Fetch & Verification Protocol ==="

# 1. Download if not present
if [ ! -f "${TARGET_ZST}" ] && [ ! -f "${TARGET_DRAT}" ]; then
    echo "[*] Downloading S10.drat.zst from remote host ${REMOTE_HOST}..."
    scp -o ConnectTimeout=10 "${REMOTE_HOST}:${REMOTE_PATH}" "${TARGET_ZST}" || {
        echo "[!] Remote SSH download failed. Please ensure omarchy is reachable."
        exit 1
    }
    echo "[+] Download complete: ${TARGET_ZST}"
fi

# 2. Verify ZST SHA-256 if ZST is present
if [ -f "${TARGET_ZST}" ]; then
    echo "[*] Verifying S10.drat.zst SHA-256 checksum..."
    ACTUAL_ZST_SHA=$(sha256sum "${TARGET_ZST}" | awk '{print $1}')
    if [ "${ACTUAL_ZST_SHA}" != "${EXPECTED_ZST_SHA}" ]; then
        echo "[!] Error: SHA-256 mismatch for S10.drat.zst!"
        echo "    Expected: ${EXPECTED_ZST_SHA}"
        echo "    Actual:   ${ACTUAL_ZST_SHA}"
        exit 1
    fi
    echo "[+] S10.drat.zst checksum verified: ${ACTUAL_ZST_SHA}"

    # Decompress if DRAT is not yet extracted
    if [ ! -f "${TARGET_DRAT}" ]; then
        echo "[*] Decompressing S10.drat.zst with zstd..."
        zstd -d -k "${TARGET_ZST}" -o "${TARGET_DRAT}"
    fi
fi

# 3. Verify decompressed DRAT SHA-256
echo "[*] Verifying uncompressed S10.drat SHA-256 checksum..."
ACTUAL_DRAT_SHA=$(sha256sum "${TARGET_DRAT}" | awk '{print $1}')
if [ "${ACTUAL_DRAT_SHA}" != "${EXPECTED_DRAT_SHA}" ]; then
    echo "[!] Error: SHA-256 mismatch for S10.drat!"
    echo "    Expected: ${EXPECTED_DRAT_SHA}"
    echo "    Actual:   ${ACTUAL_DRAT_SHA}"
    exit 1
fi
echo "[+] S10.drat checksum verified: ${ACTUAL_DRAT_SHA}"

# 4. Optional local drat-trim verification if available
if command -v drat-trim &> /dev/null && [ -f "${PROOF_DIR}/S10.cnf" ]; then
    echo "[*] Re-running drat-trim on local machine..."
    drat-trim "${PROOF_DIR}/S10.cnf" "${TARGET_DRAT}"
    echo "[+] Local drat-trim verified successfully!"
fi

echo "[SUCCESS] S10 proof artifact is authentic, verified, and ready."
