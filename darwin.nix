{ pkgs, ... }: {
  # Nix configuration
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.hostPlatform = "aarch64-darwin";

  # SYSTEM DEFAULTS
  # This is the "killer feature" - configuring macOS settings declaratively.
  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = false; # Don't rearrange spaces based on recent use
      show-recents = false;
    };
    finder = {
      AppleShowAllFiles = true;
      FXPreferredViewStyle = "clmv"; # Column view
    };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      KeyRepeat = 2; # Fast key repeat
    };
  };

  # ENABLE TOUCHID FOR SUDO
  security.pam.enableSudoTouchIdAuth = true;

  # HOMEBREW CONFIGURATION
  # This allows you to install GUI apps declaratively
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap"; # Uninstall apps not listed here
    casks = [
      "ghostty" # The terminal you use
      "raycast"
      "stats"
      "google-chrome"
    ];
    masApps = {
      # "Xcode" = 497799835;
    };
  };

  # SHELL
  programs.zsh.enable = true; # Required for nix-darwin to manage zsh

  # SYSTEM PACKAGES
  # Global packages available to all users
  environment.systemPackages = [
    pkgs.vim
    pkgs.git
  ];

  # STATE VERSION
  system.stateVersion = 5;
}
