# Gemini Context: Nix Home Manager Configuration

This directory contains a declarative [Nix](https://nixos.org/) configuration for managing a user's environment using [Home Manager](https://github.com/nix-community/home-manager) and [Flakes](https://nixos.wiki/wiki/Flakes).

## Project Overview

The configuration is structured to be modular and portable across different systems. It defines packages, shell settings, and application configurations declaratively, ensuring a reproducible and consistent user environment.

- **Purpose**: To manage a user's dotfiles and environment settings using Nix.
- **Main Technologies**: Nix, Nix Flakes, Home Manager
- **Architecture**: The configuration is split across several files:
    - `flake.nix`: The entry point for the Nix Flake. It defines the inputs (Nixpkgs, Home Manager) and outputs (the `homeConfigurations` for different users/systems).
    - `shell.nix`: Defines the base shell environment, including a list of packages to be installed and imports for application-specific configurations.
    - `appConfigs/`: Contains configurations for specific applications like Neovim (`nvim.nix`) and Starship (`starship.nix`).
    - `profiles/`: Contains user-specific configurations, such as username, home directory, and shell aliases.

## Key Files and Packages

### Core Configuration
- **`flake.nix`**: Defines two main configurations:
    - `benjamincurrie`: for `aarch64-darwin` (Apple Silicon Mac).
    - `nrm`: for `x86_64-linux`.
- **`shell.nix`**: Defines the base shell environment. Packages are organized into the following categories:
    - **Development Tools**: `nixfmt-rfc-style`, `github-cli`, `gemini-cli`.
    - **Shell & Terminal**: `starship`, `zellij`, `yazi`, `eza`, `bat`.
    - **System & Network Monitoring**: `btop`, `gping`, `neofetch`, `tailscale`, `speedtest-cli`.
    - **Fun & Miscellaneous**: `cmatrix`, `cowsay`, `figlet`.
- **`profiles/benjamincurrie.nix`**:
    - Sets up Zsh (`programs.zsh`) as the default shell.
    - Defines several useful aliases, such as `hmswitch` to apply the configuration.

### Application Configurations
- **`appConfigs/nvim.nix`**: Configures Neovim using LazyVim.
    - **Simplified Setup**: Removed unused language servers (Markdown, Cargo, Go, Python, GCC) and "extras" (Yanky, Trouble, Markdown) to reduce noise.
    - **Visuals**: kept animations (`mini-animate`) and code outline (`aerial`).
    - **UI**: Disabled `bufferline` (tabs) and `showtabline` for a focused, single-file editing experience.
- **`appConfigs/starship.nix`**: Provides a detailed, custom [Starship](https://starship.rs/) prompt configuration with a `tokyonight` theme.

## Building and Running

### Prerequisites
1.  **Install Nix**: Follow the instructions at [nixos.org/nix/install](https://nixos.org/nix/install).
2.  **Enable Flakes**: Add `experimental-features = nix-command flakes` to your `nix.conf`.

### First-Time Installation (Bootstrap)
On a new machine, clone the repository and run the following command, replacing `<username>` with the target configuration name from `flake.nix` (e.g., `benjamincurrie`):

```bash
# Build the activation package
nix build .#homeConfigurations."<username>".activationPackage

# Activate the configuration
./result/activate
```

### Applying Updates
After the initial setup, you can apply any changes to the configuration with the following command:

```bash
# For the 'benjamincurrie' configuration
home-manager switch --flake .#benjamincurrie
```

The `hmswitch` alias is also available in the Zsh configuration for this purpose.

## Development Conventions

- **Formatting**: The project uses `nixfmt-rfc-style` for formatting Nix code.
- **Modularity**: Configurations are split into logical files (base shell, applications, user profiles) to keep them organized and maintainable.
- **Declarative Packages**: All tools and applications are installed declaratively via Nix packages, avoiding the need for manual installation or separate package managers.
