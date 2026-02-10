# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Apply changes after editing any .nix file
hmswitch

# Manual equivalent (without git add)
home-manager switch --flake ~/src/nix#benjamincurrie

# Format Nix code
nixfmt <file.nix>
```

## Architecture

This is a Nix Home Manager configuration using Flakes. It manages dotfiles and packages declaratively across macOS (Apple Silicon) and Linux.

**Entry Flow:**
```
flake.nix
    └── homeConfigurations
        ├── "benjamincurrie" (aarch64-darwin) → shell.nix + profiles/benjamincurrie.nix
        └── "nrm" (x86_64-linux) → shell.nix + profiles/nrm.nix
```

**Module Structure:**
- `shell.nix` - Base packages and imports all appConfigs. This is the shared foundation.
- `profiles/` - User-specific settings (shell config, aliases, home directory paths)
- `appConfigs/` - Application-specific modules (nvim, starship, zellij, ghostty)

**Key Pattern:** Application configs in `appConfigs/` are imported by `shell.nix`, making them available to all profiles. Profile-specific overrides go in `profiles/`.

## Important Notes

- Ghostty is NOT installed via Nix (marked broken on aarch64-darwin). Install manually; Nix only manages its config file.
- The `hmswitch` alias runs `git add .` before switching - this is required because Flakes only see tracked files.
- Theme: "Double Espresso" (Gruvbox Dark Hard base) is used consistently across starship, zellij, and ghostty.
