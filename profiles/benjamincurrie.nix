{pkgs, ...}: {
  home.username = "benjamincurrie";
  home.homeDirectory = "/Users/benjamincurrie";
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      clear
      fastfetch
    '';
    shellAliases = {
      z = "zellij attach main";
      y = "yazi";
      obdir = "cd /Users/benjamincurrie/Library/Mobile\\ Documents/iCloud\\~md\\~obsidian/Documents/Obsidian";
      hmswitch = "git add . && home-manager switch --flake ~/src/nix#benjamincurrie";
      dashboard = "zellij --layout dashboard";
    };
  };
}
