# Glitch Linux APT Repository

Custom package repository for Glitch Linux tools and utilities.
**GPG-signed for secure package verification.**

## Quick Setup

### Automated (Recommended)
```bash
curl -fsSL https://glitchlinux.com/apt/setup.sh | bash
```

### Manual
```bash
# 1. Add GPG key
curl -fsSL https://glitchlinux.com/apt/KEY.gpg | sudo tee /usr/share/keyrings/glitchlinux-archive-keyring.gpg > /dev/null

# 2. Add repository
echo "deb [signed-by=/usr/share/keyrings/glitchlinux-archive-keyring.gpg] https://glitchlinux.com/apt stable main" | sudo tee /etc/apt/sources.list.d/glitchlinux.list

# 3. Update
sudo apt update
```

## Available Packages

### glitchinstall (v1.0)
PyQt5-based graphical installer for Glitch Linux and Debian-based systems
- Partition management (ext4, ext3, swap, FAT32)
- LUKS encryption support with customizable passphrases
- UEFI/BIOS bootloader installation (GRUB2)
- Full system configuration
- Installation time tracking and progress reporting

**Install:** `sudo apt install glitchinstall`

### qemu-quickboot (v1.5)
Fastest and most capable QEMU VM manager with minimal dependencies
- YAD-based GUI (only 4MB!)
- BIOS/UEFI boot support
- SSH port forwarding (default 2222)
- HMP VM power controls (pause/resume/stop)
- USB device attach/detach
- Auto-detection of UEFI on target images

**Install:** `sudo apt install qemu-quickboot`

## Repository Information

- **Origin:** Glitch Linux
- **Suite:** stable
- **Codename:** glitch-custom
- **Architectures:** amd64, arm64, all
- **Component:** main
- **GPG Key ID:** 5BD85A76D2B43C20C1DDE22D3957AA6F4BBE299C
- **Fingerprint:** https://glitchlinux.com/apt/KEY.gpg

## Security

All packages in this repository are GPG-signed with the Glitch Linux Repository key. Package verification is automatic when using the signed-by directive in sources.list.

## Installation Example

```bash
# One-liner setup + install
curl -fsSL https://glitchlinux.com/apt/setup.sh | bash && sudo apt install glitchinstall qemu-quickboot
```

## Repository Maintenance

- Packages are built and released from: https://github.com/GlitchLinux/
- New versions are added automatically to the `stable` release channel
- For source code and build details, visit individual package repositories

## Support

- Issues: https://github.com/GlitchLinux/
- Questions: https://glitchlinux.com/

