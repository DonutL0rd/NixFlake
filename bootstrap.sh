#!/usr/bin/env bash
set -euo pipefail

# Bootstrap script for new Ubuntu machine
# Usage: bash bootstrap.sh [username]
# Defaults to current user if no argument given

USERNAME="${1:-$(whoami)}"
NIX_REPO="https://github.com/DonutL0rd/nix.git"
NIX_DIR="$HOME/src/nix"

echo "==> Bootstrapping Nix for user: $USERNAME"

# 1. Install Nix (multi-user)
if ! command -v nix &>/dev/null; then
  echo "==> Installing Nix..."
  curl -L https://nixos.org/nix/install | sh -s -- --daemon
  # Source nix for the rest of this script
  . /etc/profile.d/nix.sh
else
  echo "==> Nix already installed, skipping."
fi

# 2. Enable flakes
if ! grep -q "experimental-features" /etc/nix/nix.conf 2>/dev/null; then
  echo "==> Enabling flakes and nix-command..."
  echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf
  sudo systemctl restart nix-daemon 2>/dev/null || true
fi

# 3. Install git if missing (needed to clone)
if ! command -v git &>/dev/null; then
  echo "==> Installing git..."
  sudo apt-get update -q && sudo apt-get install -y -q git
fi

# 4. Clone this repo
if [ ! -d "$NIX_DIR" ]; then
  echo "==> Cloning nix config to $NIX_DIR..."
  mkdir -p "$(dirname "$NIX_DIR")"
  git clone "$NIX_REPO" "$NIX_DIR"
else
  echo "==> Nix config already present at $NIX_DIR, pulling latest..."
  git -C "$NIX_DIR" pull
fi

# 5. Run home-manager switch
echo "==> Running home-manager switch for profile: $USERNAME..."
nix run home-manager/master -- switch --flake "$NIX_DIR#$USERNAME"

echo ""
echo "==> Done! Restart your shell or run: source ~/.bashrc"
