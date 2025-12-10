{pkgs, ...}: {
    home.username = "benjamincurrie";
    home.homeDirectory = "/Users/benjamincurrie";    
    home.stateVersion = "24.11"; # Comment out for error with "latest" version
    programs.home-manager.enable = true;
       # Add this somewhere in `home.nix`
    home.packages = [
        pkgs.nixfmt-rfc-style
        pkgs.cowsay
        pkgs.starship
    ];

    programs.starship = {
        enable = true;
        enableZshIntegration = true;~
    };
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
            ll = "ls -la";
            hmswitch = "home-manager switch --flake ~/src/nix#benjamincurrie";
        }; 
    };

}