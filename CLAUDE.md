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
- **`shell.nix`**: Defines the base packages.
    - **Development**: `nixfmt`, `gh`, `gemini-cli`, `k9s`, `lazydocker`.
    - **Terminal**: `starship`, `zellij`, `yazi`, `eza`, `bat`, `glow`.
    - **Monitoring**: `btop`, `gping`, `neofetch`, `tailscale`.
    - **Fun**: `cmatrix`, `cowsay`, `sl`.
- **`profiles/`**: User-specific logic.
    - `benjamincurrie.nix`: Zsh configuration, aliases, and screensaver logic.
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

### Zsh (Shell)
- **Screensaver**: Auto-triggers `cmatrix -s -b` after 5 minutes of inactivity at the prompt.
- **Aliases**:
    - `hmswitch`: Applies the Home Manager configuration (`git add . && home-manager switch ...`).
    - `dashboard`: Launches the Zellij dashboard layout.
    - `cat` -> `bat`, `ls` -> `eza`, `y` -> `yazi`.

## Workflows

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
- **Jan 28, 2026**:
    - Attempted migration to `nix-darwin` but reverted to stable Home Manager due to bootstrapping complexity.
    - Added `ghostty` configuration with custom shaders and themes.
    - Added `glow` (Markdown reader) to `shell.nix`.
    - Removed experimental `wtf` AI function from Zsh profile.