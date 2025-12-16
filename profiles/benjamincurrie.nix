    {pkgs, ...}: {
    home.username = "benjamincurrie";
    home.homeDirectory = "/Users/benjamincurrie";    
    home.stateVersion = "24.11"; # Comment out for error with "latest" version
    programs.home-manager.enable = true;

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        initExtra = ''
          clear
          neofetch 
          '';
        shellAliases = {
            cat = "bat -pp";
            ls = "eza --icons -F -H --group-directories-first --git -1";
            z = "zellij attach main";
            obdir = "cd /Users/benjamincurrie/Library/Mobile\\ Documents/iCloud\\~md\\~obsidian/Documents/Obsidian";
            hmswitch = "home-manager switch --flake ~/src/nix#benjamincurrie";
        }; 
    };
}
