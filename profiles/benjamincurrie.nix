    {pkgs, ...}: {
    home.username = "benjamincurrie";
    home.homeDirectory = "/Users/benjamincurrie";    
    home.stateVersion = "24.11"; # Comment out for error with "latest" version
    programs.home-manager.enable = true;

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        initExtra = ''
          clear
          neofetch 

          # Screensaver (5 minutes idle)
          # Only triggers when at the prompt, not while running commands.
          TMOUT=300
          TRAPALRM() {
            cmatrix -s -b
          }
        '';
        shellAliases = {
            cat = "bat -pp";
            ls = "eza --icons -F -H --group-directories-first --git -1";
            z = "zellij attach main";
            y = "yazi";
            obdir = "cd /Users/benjamincurrie/Library/Mobile\\ Documents/iCloud\\~md\\~obsidian/Documents/Obsidian";
            hmswitch = "git add . && home-manager switch --flake ~/src/nix#benjamincurrie";
            dashboard = "zellij --layout dashboard";
        }; 
    };
}
