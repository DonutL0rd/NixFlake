================================================================================
NIX HOME MANAGER CONFIGURATION
================================================================================

Declarative user environment using Nix Flakes and Home Manager.
Works on macOS (Apple Silicon) and Linux.

================================================================================
PREREQUISITES
================================================================================

1. Install Nix with daemon mode:

   sh <(curl -L <https://nixos.org/nix/install>) --daemon

2. Enable flakes (required):

   mkdir -p ~/.config/nix
   echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

3. Restart your terminal

================================================================================
FIRST-TIME SETUP (NEW MACHINE)
================================================================================

## Step 1: Clone this repo

mkdir -p ~/src
git clone <YOUR_REPO_URL> ~/src/nix
cd ~/src/nix

## Step 2: Backup existing dotfiles

Home Manager will fail if these files exist. Back them up:

[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.backup
[ -f ~/.profile ] && mv ~/.profile ~/.profile.backup
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.backup

## Step 3: Build and activate

Replace <username> with: benjamincurrie (macOS) or nrm (Linux)

nix build .#homeConfigurations."<username>".activationPackage
./result/activate

## Step 4: Restart shell

exec $SHELL

================================================================================
DAILY USAGE
================================================================================

After first setup, apply changes with:

cd ~/src/nix
home-manager switch --flake .#<username>

Or use the alias:

hmswitch

================================================================================
POST-INSTALL: TAILSCALE
================================================================================

Tailscale needs system-level setup (one time per machine).

## macOS

brew install --cask tailscale
tailscale up

## Linux

See: <https://tailscale.com/download/linux>
Then run: tailscale up

================================================================================
ADDING PACKAGES
================================================================================

1. Edit shell.nix
2. Add package to home.packages list
3. Run: hmswitch

Search packages: <https://search.nixos.org/packages>

================================================================================
TROUBLESHOOTING
================================================================================

## Error: "file exists"

You didn't backup dotfiles. Move them manually:
mv ~/.bashrc ~/.bashrc.backup (repeat for .profile, .zshrc)

## Error: "experimental features not enabled"

Add to ~/.config/nix/nix.conf:
experimental-features = nix-command flakes
Then restart terminal.

## Changes not applying

Make sure you're in ~/src/nix when running home-manager switch

================================================================================
DIRECTORY STRUCTURE
================================================================================

flake.nix Entry point, system configs
shell.nix Base packages and environment
profiles/ User-specific settings
└─ benjamincurrie.nix
appConfigs/ Application configs
├─ nvim.nix Neovim (LazyVim)
└─ starship.nix Shell prompt theme

