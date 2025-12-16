#!/usr/bin/env bash

set -euo pipefail # Exit on error, undefined vars, pipe failures

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
  echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warn() {
  echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

# Cleanup function for failures
cleanup_on_error() {
  log_error "Installation failed. Cleaning up..."

  # Remove result symlink if it exists
  if [ -L "./result" ]; then
    rm -f ./result
    log_info "Removed result symlink"
  fi

  exit 1
}

# Set trap for errors
trap cleanup_on_error ERR

# Banner
echo "================================================================================"
echo "  NIX HOME MANAGER INSTALLATION"
echo "================================================================================"
echo ""

# Check if we're in the right directory
if [ ! -f "flake.nix" ]; then
  log_error "flake.nix not found. Run this script from the repository root."
  exit 1
fi

log_success "Found flake.nix"

# Check if Nix is installed
if ! command -v nix &>/dev/null; then
  log_error "Nix is not installed."
  echo ""
  echo "Install Nix with:"
  echo "  sh <(curl -L https://nixos.org/nix/install) --daemon"
  exit 1
fi

log_success "Nix is installed"

# Check if flakes are enabled
if ! nix flake metadata --json &>/dev/null; then
  log_error "Nix flakes are not enabled."
  echo ""
  echo "Enable flakes by adding this to ~/.config/nix/nix.conf:"
  echo "  experimental-features = nix-command flakes"
  echo ""
  echo "Then restart your terminal."
  exit 1
fi

log_success "Flakes are enabled"

# Detect system and suggest username
if [[ "$OSTYPE" == "darwin"* ]]; then
  SUGGESTED_USER="benjamincurrie"
  SYSTEM_TYPE="macOS (Darwin)"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  SUGGESTED_USER="nrm"
  SYSTEM_TYPE="Linux"
else
  log_warn "Unknown system type: $OSTYPE"
  SUGGESTED_USER=""
  SYSTEM_TYPE="Unknown"
fi

log_info "Detected system: $SYSTEM_TYPE"

# Prompt for username
echo ""
echo "Available configurations in flake.nix:"
echo "  - benjamincurrie (aarch64-darwin / macOS)"
echo "  - nrm (x86_64-linux)"
echo ""

if [ -n "$SUGGESTED_USER" ]; then
  read -p "Enter username [$SUGGESTED_USER]: " USERNAME
  USERNAME=${USERNAME:-$SUGGESTED_USER}
else
  read -p "Enter username: " USERNAME
fi

if [ -z "$USERNAME" ]; then
  log_error "Username cannot be empty"
  exit 1
fi

log_info "Using configuration: $USERNAME"

# Verify configuration exists in flake
if ! nix flake show --json 2>/dev/null | grep -q "homeConfigurations.*$USERNAME"; then
  log_error "Configuration '$USERNAME' not found in flake.nix"
  exit 1
fi

log_success "Configuration '$USERNAME' exists"

# Backup existing dotfiles
echo ""
log_info "Backing up existing dotfiles..."

FILES_TO_BACKUP=(
  "$HOME/.bashrc"
  "$HOME/.profile"
  "$HOME/.zshrc"
)

BACKUP_COUNT=0

for file in "${FILES_TO_BACKUP[@]}"; do
  if [ -f "$file" ]; then
    BACKUP_FILE="${file}.backup.$(date +%Y%m%d_%H%M%S)"
    mv "$file" "$BACKUP_FILE"
    log_success "Backed up: $file -> $BACKUP_FILE"
    BACKUP_COUNT=$((BACKUP_COUNT + 1))
  fi
done

if [ $BACKUP_COUNT -eq 0 ]; then
  log_info "No dotfiles to backup"
else
  log_success "Backed up $BACKUP_COUNT file(s)"
fi

# Build the activation package
echo ""
log_info "Building Home Manager configuration..."
log_info "This may take several minutes on first run..."

if ! nix build ".#homeConfigurations.\"$USERNAME\".activationPackage" --show-trace; then
  log_error "Build failed. Check the error output above."
  exit 1
fi

log_success "Build complete"

# Verify result exists
if [ ! -L "./result" ]; then
  log_error "Build succeeded but ./result symlink not found"
  exit 1
fi

# Activate the configuration
echo ""
log_info "Activating Home Manager configuration..."

if ! ./result/activate; then
  log_error "Activation failed"
  exit 1
fi

log_success "Activation complete"

# Final instructions
echo ""
echo "================================================================================"
log_success "Installation complete!"
echo "================================================================================"
echo ""
echo "Next steps:"
echo ""
echo "  1. Restart your shell:"
echo "       exec \$SHELL"
echo ""
echo "  2. (Optional) Install Tailscale system service:"
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "       brew install --cask tailscale"
  echo "       tailscale up"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo "       See: https://tailscale.com/download/linux"
  echo "       tailscale up"
fi
echo ""
echo "  3. To apply future changes:"
echo "       cd ~/src/nix"
echo "       hmswitch"
echo ""
echo "================================================================================"
