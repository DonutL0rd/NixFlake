
# Nix Home Configuration

This repository contains the declarative configuration for my user environment using Nix Flakes and Home Manager.

## Prerequisites

1.  **Install Nix:**
    ```bash
    sh <(curl -L [https://nixos.org/nix/install](https://nixos.org/nix/install)) --daemon
    ```

2.  **Enable Flakes:**
    Ensure `~/.config/nix/nix.conf` or `/etc/nix/nix.conf` contains:
    ```text
    experimental-features = nix-command flakes
    ```

---

## Installation (Bootstrap)

Follow these steps only when setting up this configuration on a new machine for the first time.

### 1. Clone the Repository
Clone this to your preferred source directory (e.g., `~/src/nix`):

```bash
mkdir -p ~/src
git clone <YOUR_REPO_URL> ~/src/nix
cd ~/src/nix
````

### 2. Back up Existing Shell Configs

Home Manager will fail if it detects existing configuration files (like `.bashrc` or `.profile`) that it intends to manage. Move them to a backup location:

Bash

```
# Back up .bashrc if it exists
[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.backup

# Back up .profile if it exists (common on non-NixOS systems)
[ -f ~/.profile ] && mv ~/.profile ~/.profile.backup
```

### 3. Build and Activate

Replace `<your-username>` with the actual username defined in `flake.nix`:

Bash

```
# Build the activation package
nix build .#homeConfigurations."<your-username>".activationPackage

# Activate the configuration
./result/activate
```

---

## Usage

### Applying Updates

Once the bootstrap is complete, you do not need to build the activation package manually. Apply changes using `home-manager`:

Bash

```
# Navigate to repo
cd ~/src/nix

# Switch to the new configuration
home-manager switch --flake .#<your-username>
```

---

## Directory Structure

- `flake.nix`: Entry point and dependencies.
    
- `home.nix`: Main user configuration.
    


***

### Strategic Notes & Fixes

1.  **Safety Check (The `mv` command):** Your original command `mv ~/.bashrc ~./backupbashrc` contained a syntax error (`~./`). I changed this to standard backup naming (`.backup`) and added a check `[ -f ... ]` so the command doesn't fail if the file doesn't exist.
2.  **The "Bootstrap" Distinction:** I separated the `nix build ... activationPackage` step from the `home-manager switch` step.
    * **Why:** `nix build` is usually only needed the very first time (bootstrapping) to install the `home-manager` binary itself. Once installed, `home-manager switch` is the faster, standard way to work.
3.  **Placeholders:** I replaced `"your.name"` and `#{home.username}` with `<your-username>` to make it clear where the user needs to input their specific variable.

**Next Step:** Would you like me to write a script to automate that "Backup and Check" step so you don't have to run those commands manually every time you provision a new machine?