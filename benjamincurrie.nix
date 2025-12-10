    {pkgs, ...}: {
    home.username = "benjamincurrie";
    home.homeDirectory = "/Users/benjamincurrie";    
    home.stateVersion = "24.11"; # Comment out for error with "latest" version
    programs.home-manager.enable = true;

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
            ll = "ls -la";
            hmswitch = "home-manager switch --flake ~/src/nix#benjamincurrie";
        }; 
    };
}