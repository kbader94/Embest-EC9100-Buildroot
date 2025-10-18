#!/bin/sh
set -e

# Buildroot passes these:
#  - HOST_DIR:    .../output/host
#  - BINARIES_DIR .../output/images
#  - TARGET_DIR   .../output/target

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
MKIMAGE="${HOST_DIR}/bin/mkimage"

# Build boot.scr
"${MKIMAGE}" -A arm -O linux -T script -C none \
  -d "${SCRIPT_DIR}/boot.scr.txt" \
  "${BINARIES_DIR}/boot.scr"

# Generate sdcard.img
GENIMAGE_TMP="${BINARIES_DIR}/genimage.tmp"
rm -rf "${GENIMAGE_TMP}"

genimage \
  --rootpath   "${TARGET_DIR}" \
  --tmppath    "${GENIMAGE_TMP}" \
  --inputpath  "${BINARIES_DIR}" \
  --outputpath "${BINARIES_DIR}" \
  --config     "${SCRIPT_DIR}/genimage.cfg"

echo "[post-image] sdcard.img ready at ${BINARIES_DIR}/sdcard.img"

