    {pkgs, ...}: {
    home.username = "benjamincurrie";
    home.homeDirectory = "/Users/benjamincurrie";    
    home.stateVersion = "24.11"; # Comment out for error with "latest" version
    programs.home-manager.enable = true;

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        initExtra = ''
          neofetch 
          '';
        shellAliases = {
            ll = "ls -la";
            z = "zellij attach main";
            obdir = "cd /Users/benjamincurrie/Library/Mobile\\ Documents/iCloud\\~md\\~obsidian/Documents/Obsidian";
            hmswitch = "home-manager switch --flake ~/src/nix#benjamincurrie";
        }; 
    };
}
