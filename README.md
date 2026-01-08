# Nix Home Manager Configuration

A robust, modular, and reproducible user environment configuration powered by [Nix](https://nixos.org/), [Nix Flakes](https://nixos.wiki/wiki/Flakes), and [Home Manager](https://github.com/nix-community/home-manager).

Designed to provide a consistent development experience across **macOS (Apple Silicon)** and **Linux (x86_64)** systems.

## 🚀 Features

*   **Cross-Platform:** specialized configurations for macOS (`benjamincurrie`) and Linux (`nrm`).
*   **Declarative Package Management:** All tools and versions are defined in code.
*   **Modern Terminal Experience:**
    *   **Shell:** Zsh (macOS) and Bash (Linux) with a custom [Starship](https://starship.rs) prompt (Tokyo Night theme).
    *   **Tools:** `zellij` (multiplexer), `yazi` (file manager), `eza` (ls replacement), `bat` (cat replacement), `fzf`, `ripgrep`.
*   **Neovim IDE:** A fully configured [LazyVim](https://www.lazyvim.org/) setup with language servers for Nix, Lua, Shell, and Web technologies.
*   **Automated Installation:** Includes a robust `install.sh` script to handle setup, backups, and activation.

## 📂 Directory Structure

```text
├── flake.nix             # Entry point: defines inputs, outputs, and systems
├── shell.nix             # Core package list and module imports
├── install.sh            # Automated installation script
├── nixInstall.sh         # Quick script to install Nix package manager
├── appConfigs/           # Application-specific configurations
│   ├── nvim.nix          # Neovim (LazyVim) configuration
│   └── starship.nix      # Starship prompt theme and settings
└── profiles/             # User-specific profiles
    ├── benjamincurrie.nix # macOS configuration (Zsh, aliases)
    └── nrm.nix           # Linux configuration (Bash, aliases)
```

## 🛠️ Prerequisites

1.  **Install Nix:**
    You can use the provided helper script:
    ```bash
    ./nixInstall.sh
    ```
    Or install manually:
    ```bash
    sh <(curl -L https://nixos.org/nix/install) --daemon
    ```

2.  **Enable Flakes:**
    Create `~/.config/nix/nix.conf` and add:
    ```ini
    experimental-features = nix-command flakes
    ```
    *Restart your terminal after this step.*

## ⚡ Installation

The included `install.sh` script handles everything: detecting your OS, backing up existing dotfiles (`.zshrc`, `.bashrc`, etc.), building the configuration, and activating it.

1.  **Clone the repository:**
    ```bash
    mkdir -p ~/src
    git clone https://github.com/YOUR_USERNAME/nix.git ~/src/nix
    cd ~/src/nix
    ```

2.  **Run the installer:**
    ```bash
    ./install.sh
    ```

3.  **Follow the prompts:**
    *   The script will suggest a username based on your OS (`benjamincurrie` for macOS, `nrm` for Linux).
    *   Enter the desired username or press Enter to accept the default.

4.  **Restart your shell:**
    ```bash
    exec $SHELL
    ```

## 🔄 Management & Updates

### Applying Changes
After editing any file in this repository, apply the changes using the `hmswitch` alias (automatically installed) or the direct command:

```bash
# Using the alias
hmswitch

# Manual command
home-manager switch --flake .#<username>
```

### Adding Packages
1.  Open `shell.nix`.
2.  Add the package name to the relevant list (e.g., `developmentTools`, `fun`).
    *   *Tip: Search for package names at [search.nixos.org](https://search.nixos.org/packages).*
3.  Run `hmswitch`.

## 🧩 Key Components

### Neovim (LazyVim)
Configured in `appConfigs/nvim.nix`.
*   **Core:** Treesitter, LSP support (Nix, Lua, Bash, Docker, Web), Telescope.
*   **UI:** Custom Tokyo Night theme integration via Starship.
*   **Plugins:** `mini.animate`, `aerial` (code outline), and more.

### Starship Prompt
Configured in `appConfigs/starship.nix`.
*   Custom "Tokyo Night" palette.
*   Context-aware modules for Git, Nix, Docker, Kubernetes, and various languages.

### Shell Aliases
*   `ls` -> `eza --icons ...`
*   `cat` -> `bat -pp`
*   `z` -> `zellij attach main`
*   `y` -> `yazi`
*   `hmswitch` -> Rebuilds and switches to the current flake configuration.

## 🖥️ Supported Profiles

| Profile | System | Shell | Description |
| :--- | :--- | :--- | :--- |
| `benjamincurrie` | `aarch64-darwin` | Zsh | Primary macOS configuration for Apple Silicon. |
| `nrm` | `x86_64-linux` | Bash | Standard Linux configuration. |
| `vm` | `aarch64-linux` | - | NixOS VM configuration (experimental). |