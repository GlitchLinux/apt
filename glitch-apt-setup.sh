#!/bin/bash
# Glitch Linux APT Repository Setup
# https://glitchlinux.com/apt

set -e

REPO_URL="https://glitchlinux.com/apt"
KEY_URL="$REPO_URL/KEY.gpg"
KEY_PATH="/usr/share/keyrings/glitchlinux-archive-keyring.gpg"
SOURCES_LIST="/etc/apt/sources.list.d/glitchlinux.list"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_info() {
    echo -e "${YELLOW}[INFO]${NC} $1"
}

# Check if running as root or with sudo
if [[ $EUID -ne 0 ]]; then
    print_error "This script must be run with sudo privileges"
    echo "Usage: sudo $0"
    exit 1
fi

echo "══════════════════════════════════════"
echo "  Glitch Linux APT Repository Setup"
echo "══════════════════════════════════════"
echo ""

# Step 1: Download GPG key
print_info "Downloading GPG public key..."
if ! curl -fsSL "$KEY_URL" -o "$KEY_PATH"; then
    print_error "Failed to download GPG key from $KEY_URL"
    exit 1
fi
chmod 644 "$KEY_PATH"
print_success "GPG key installed to $KEY_PATH"
echo ""

# Step 2: Verify GPG key exists and is valid
print_info "Verifying GPG key..."
if ! file "$KEY_PATH" | grep -q "PGP public key"; then
    print_error "Downloaded file is not a valid GPG key"
    rm -f "$KEY_PATH"
    exit 1
fi

# Extract key fingerprint
KEY_ID=$(gpg --show-keys --with-colons "$KEY_PATH" 2>/dev/null | grep "^fpr" | cut -d: -f10 | head -1)
if [ -z "$KEY_ID" ]; then
    print_error "Could not extract key fingerprint"
    rm -f "$KEY_PATH"
    exit 1
fi
print_success "GPG key verified (fingerprint: ${KEY_ID:0:16}...)"
echo ""

# Step 3: Add repository to sources.list
print_info "Adding repository to $SOURCES_LIST..."
cat > "$SOURCES_LIST" << APT
# Glitch Linux Custom Repository
# https://glitchlinux.com/apt
deb [signed-by=$KEY_PATH] $REPO_URL stable main
APT

chmod 644 "$SOURCES_LIST"
print_success "Repository added"
echo ""

# Step 4: Update package cache
print_info "Updating package cache..."
if ! apt-get update 2>&1 | grep -q "glitchlinux.com"; then
    print_error "Repository not accessible during update"
    exit 1
fi
print_success "Package cache updated"
echo ""

# Step 5: Display available packages
print_info "Querying available packages..."
echo ""

FOUND=0
for pkg in qemu-quickboot glitchinstall; do
    if apt-cache show "$pkg" &>/dev/null; then
        VERSION=$(apt-cache show "$pkg" | grep "^Version:" | awk '{print $2}')
        DESC=$(apt-cache show "$pkg" | grep "^Description:" | sed 's/Description: //')
        printf "  • %-20s v%-6s  %s\n" "$pkg" "$VERSION" "$DESC"
        FOUND=$((FOUND + 1))
    fi
done

if [ $FOUND -eq 0 ]; then
    print_error "No packages found in repository"
    exit 1
fi
echo ""

echo "═════════════════════════"
print_success "Setup Complete!"
echo "═════════════════════════"
echo ""
echo "Install with:"
echo "  sudo apt install qemu-quickboot glitchinstall"
echo ""
echo "Repository:"
echo "  URL:  $REPO_URL"
echo "  Key:  $KEY_PATH"
echo ""
