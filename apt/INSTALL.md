# Installing Glitch Linux Repository

## Quick Setup (Recommended)

### One-Liner
```bash
curl -fsSL https://glitchlinux.com/apt/setup.sh | sudo bash
```

### Step-by-Step (Manual)

1. **Download and verify GPG key**
```bash
curl -fsSL https://glitchlinux.com/apt/KEY.gpg | sudo tee /usr/share/keyrings/glitchlinux-archive-keyring.gpg > /dev/null
```

2. **Add repository to sources.list**
```bash
echo "deb [signed-by=/usr/share/keyrings/glitchlinux-archive-keyring.gpg] https://glitchlinux.com/apt stable main" | sudo tee /etc/apt/sources.list.d/glitchlinux.list
```

3. **Update package cache**
```bash
sudo apt update
```

4. **Install packages**
```bash
sudo apt install qemu-quickboot glitchinstall
```

## Verification

Verify the repository is working:
```bash
apt-cache search qemu-quickboot glitchinstall
```

Should show:
```
qemu-quickboot - QEMU VM Manager with YAD GUI
glitchinstall - System Installer for gLiTcH Linux
```

## Repository Information

| Field | Value |
|-------|-------|
| URL | https://glitchlinux.com/apt |
| Suite | stable |
| Component | main |
| Architectures | amd64, arm64, all |
| GPG Key ID | 5BD85A76D2B43C20C1DDE22D3957AA6F4BBE299C |
| Signed | Yes (GPG-signed Release files) |

## Available Packages

### qemu-quickboot (v1.5)
Fast QEMU VM manager with minimal dependencies (YAD only, 4MB)
- BIOS/UEFI boot support
- SSH port forwarding
- USB device management
- VM power controls

**Install:** `sudo apt install qemu-quickboot`

### glitchinstall (v1.0)
PyQt5-based graphical installer for Glitch Linux and Debian-based systems
- Partition management
- LUKS encryption
- UEFI/BIOS bootloader installation
- Full system configuration

**Install:** `sudo apt install glitchinstall`

## Troubleshooting

### "GPG key not found" error
Make sure the key was downloaded correctly:
```bash
curl -fsSL https://glitchlinux.com/apt/KEY.gpg | gpg
```

### "Repository not found" error
Verify the sources.list entry:
```bash
cat /etc/apt/sources.list.d/glitchlinux.list
```

Should contain:
```
deb [signed-by=/usr/share/keyrings/glitchlinux-archive-keyring.gpg] https://glitchlinux.com/apt stable main
```

### Package installation fails
Run:
```bash
sudo apt update
sudo apt install -f
```

## Uninstall

To remove the repository:
```bash
sudo rm /etc/apt/sources.list.d/glitchlinux.list
sudo rm /usr/share/keyrings/glitchlinux-archive-keyring.gpg
sudo apt update
```

## Support

- Issues: https://github.com/GlitchLinux/
- Repository: https://glitchlinux.com/apt/

