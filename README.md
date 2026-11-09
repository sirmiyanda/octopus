# LegitOS Build Kit

A small, 64-bit Debian Live desktop image configured with XFCE. It boots as a live system in VirtualBox; it does not install to your virtual disk unless you later choose to add an installer.

## Included desktop apps
- Thunar file manager
- Firefox ESR web browser
- Mousepad text editor
- XFCE Terminal
- Settings manager
- Task manager (htop)
- GParted partition editor

## Build it on Debian 13 / Ubuntu under WSL2

Building a full Linux ISO requires downloading the Linux kernel and Debian packages. This kit contains the configuration and branding, not those upstream operating-system binaries.

1. Install WSL2 and a Debian 13 or Ubuntu distribution.
2. Open its terminal and extract this ZIP into your Linux home directory.
3. Run:

```bash
cd LegitOS-Build-Kit
chmod +x build.sh
./build.sh
```

4. When it finishes, the ISO will be in `../LegitOS.iso` (relative to this project directory). In VirtualBox, create a new VM:
   - Type: Linux
   - Version: Debian (64-bit)
   - RAM: 2048 MB minimum; 4096 MB recommended
   - CPUs: 2
   - Disk: create a 20 GB virtual disk (the live ISO can also run without installing)
   - Settings > Storage: attach `LegitOS.iso` to the optical drive
   - Settings > Display: Video Memory 128 MB; enable 3D Acceleration if it works reliably on your host
5. Start the VM and choose the default live boot entry.

## Notes
- Architecture: amd64 / x86_64.
- Network access is required during the build.
- The live desktop user is `legit`; the live session does not need a password for normal use.
- This is an experimental personal build, not a security-hardened or production distribution.
- The build script uses Debian's official live-build tooling and repositories. Review scripts before running them.
