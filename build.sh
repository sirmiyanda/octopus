
#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_DIR"

if [[ "${EUID}" -eq 0 ]]; then
  SUDO=""
else
  SUDO="sudo"
fi

echo "[1/4] Installing Debian Live build tools..."

$SUDO apt-get update

$SUDO apt-get install -y \
  live-build \
  debootstrap \
  debian-archive-keyring \
  squashfs-tools \
  xorriso \
  grub-pc-bin \
  grub-efi-amd64-bin \
  mtools \
  dosfstools

echo "[2/4] Configuring LegitOS..."

lb clean --purge || true

$SUDO lb config \
  --distribution trixie \
  --architectures amd64 \
  --binary-images iso-hybrid \
  --debian-installer none \
  --archive-areas "main contrib non-free non-free-firmware" \
  --mirror-bootstrap http://deb.debian.org/debian \
  --mirror-chroot http://deb.debian.org/debian \
  --mirror-binary http://deb.debian.org/debian \
  --parent-mirror-security https://security.debian.org/debian-security/ \
  --bootappend-live "boot=live components username=legit hostname=legitos locales=en_US.UTF-8 keyboard-layouts=us" \
  --iso-application "LegitOS Live" \
  --iso-publisher "LegitAfri Technologies" \
  --iso-volume "LEGITOS_LIVE"

echo "[3/4] Building LegitOS ISO..."

$SUDO lb build

echo "[4/4] Preparing ISO..."

ISO="$(find . -maxdepth 1 -type f -name '*.iso' -print -quit)"

if [[ -z "$ISO" ]]; then
  echo "ERROR: No ISO file was generated."
  exit 1
fi

cp "$ISO" "$PROJECT_DIR/../LegitOS.iso"

echo "SUCCESS: LegitOS ISO created!"
