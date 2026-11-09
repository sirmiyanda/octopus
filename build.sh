#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_DIR"

echo "[1/3] Configuring LegitOS..."

lb clean --purge || true

lb config \
  --distribution trixie \
  --architectures amd64 \
  --binary-images iso-hybrid \
  --debian-installer none \
  --archive-areas "main contrib non-free non-free-firmware" \
  --security false \
  --bootappend-live "boot=live components username=legit hostname=legitos locales=en_US.UTF-8 keyboard-layouts=us" \
  --iso-application "LegitOS Live" \
  --iso-publisher "LegitAfri Technologies" \
  --iso-volume "LEGITOS_LIVE"

echo "[2/3] Building LegitOS ISO..."

lb build

echo "[3/3] Verifying ISO..."

ISO="$(find . -maxdepth 1 -type f -name '*.iso' -print -quit)"

if [[ -z "$ISO" ]]; then
  echo "ERROR: No ISO file was generated."
  exit 1
fi

echo "SUCCESS: $ISO"
