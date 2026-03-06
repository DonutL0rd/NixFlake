# Gemini Context: Nix Home Manager Configuration

This directory contains a declarative [Nix](https://nixos.org/) configuration for managing a user's environment using [Home Manager](https://github.com/nix-community/home-manager) and [Flakes](https://nixos.wiki/wiki/Flakes).

## Project Overview

The configuration is structured to be modular and portable across different systems (macOS Apple Silicon and Linux). It defines packages, shell settings, and application configurations declaratively, ensuring a reproducible and consistent user environment.

- **Purpose**: Manage dotfiles and environment settings via Nix.
- **Main Technologies**: Nix, Nix Flakes, Home Manager.
- **Aesthetic**: "Double Espresso" (Gruvbox Dark Hard / Coffee Theme).

## Architecture

The configuration is split across several logical files:

- **`flake.nix`**: The entry point.
    - `benjamincurrie`: Configuration for `aarch64-darwin` (Apple Silicon).
    - `nrm`: Configuration for `x86_64-linux`.
- **`common.nix`**: Defines the base packages and shared configuration (formerly `shell.nix`).
    - **Development**: `nixfmt`, `gh`, `gemini-cli`, `claude-code`, `opencode`, `k9s`, `lazydocker`, `talosctl`, `kubectl`.
    - **Terminal**: `starship`, `zellij`, `yazi`, `eza`, `bat`, `glow`.
    - **Monitoring**: `btop`, `gping`, `fastfetch` (replaced `neofetch`), `tailscale`, `speedtest-cli`.
    - **Modern Unix**: `lazygit`, `ripgrep`, `fd`, `jq`.
    - **Fun**: `cmatrix`, `cowsay`, `sl`.
- **`profiles/`**: User-specific logic.
    - `benjamincurrie.nix`: Zsh configuration, aliases (`z`, `y`, `hmswitch`), and environment setup.
    - `nrm.nix`: Bash configuration for Linux environment.
- **`appConfigs/`**: Application-specific modules.
    - `ghostty.nix`: Terminal emulator configuration (Custom Theme, Shaders).
    - `zellij.nix`: Multiplexer configuration (Dashboard layout, Theme).
    - `starship.nix`: Prompt configuration (Double Espresso Theme).
    - `nvim.nix`: Neovim (LazyVim) configuration.

## Component Details

### Ghostty (Terminal)
- **Config**: Managed via `xdg.configFile` in `appConfigs/ghostty.nix`.
- **Theme**: Custom "Double Espresso" (Gruvbox Dark Hard base).
- **Features**:
    - GPU acceleration enabled.
    - **Shaders**: CRT, Bloom, and Glitch shaders are pre-configured (commented out by default).
    - **MacOS Integration**: Transparent titlebar, native tabs.
    - **Interactivity**: Click-to-move cursor, shell integration.

### Zellij (Multiplexer)
- **Theme**: Matching "Double Espresso" theme.
- **Layouts**: Includes a custom `dashboard` layout with `btop`, `cmatrix`, and `yazi` pre-split.
- **Alias**: `z` attaches to the main session.

### Starship (Prompt)
- **Theme**: "Double Espresso" Gradient.
- **Structure**:
    - **Left**: OS -> User -> Host -> Dir -> Git.
    - **Right**: Kubernetes -> Docker -> Language Versions -> Time.
- **Prompt Character**: `☕ ❯`

### Neovim (LazyVim)
- **Config**: Hybrid approach. Nix installs the package and tools (`nil`, `lua-language-server`, `shfmt`, etc.), but config files are sourced from `./appConfigs/nvim/` to `~/.config/nvim/`.
- **Languages**: Lua, Nix, Shell, YAML, JSON, Docker.

### Shell (Zsh/Bash)
- **Aliases**:
    - `hmswitch`: Applies the Home Manager configuration (`git add . && home-manager switch ...`).
    - `dashboard`: Launches the Zellij dashboard layout.
    - `cat` -> `bat`, `ls` -> `eza`, `y` -> `yazi`.
    - `vi`/`vim` -> `nvim`.

## Workflows

### Bootstrapping
A helper script `install.sh` is provided to bootstrap the environment on a new machine:
1. Checks for Nix and Flakes.
2. Backs up existing dotfiles (`.zshrc`, `.bashrc`, etc.).
3. Builds and activates the Home Manager configuration for the detected OS/User.

### Applying Changes
To apply any changes made to `.nix` files:
```bash
hmswitch
```
*Note: This runs `git add .` automatically before switching to ensure the Flake sees new files.*

### Managing Ghostty
Since `ghostty` is marked as broken on `aarch64-darwin` in `nixpkgs` (as of early 2026), the package is **not** installed via Nix.
- **Installation**: Manual (brew/dmg).
- **Configuration**: Fully managed by Nix (`appConfigs/ghostty.nix` generates `~/.config/ghostty/config`).

## Development History & Status
- **Mar 1, 2026**:
    - Added `opencode` (AI coding agent) to development tools in `common.nix`.
- **Feb 23, 2026**:
    - Confirmed `shell.nix` has been renamed/refactored to `common.nix`.
    - Added `claude-code`, `talosctl`, `kubectl` to development tools.
    - Switched from `neofetch` to `fastfetch`.
    - Documented `install.sh` bootstrapping process.
- **Jan 28, 2026**:
    - Attempted migration to `nix-darwin` but reverted to stable Home Manager.
    - Added `ghostty` configuration.
