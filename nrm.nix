   {pkgs, ...}: {
    home.username = "nrm";
    home.homeDirectory = "/home/nrm";    
    home.stateVersion = "24.11"; # Comment out for error with "latest" version
    programs.home-manager.enable = true;
    
    programs.bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
            ll = "ls -la";
            hmswitch = "home-manager switch --flake ~/src/nix#nrm";
        }; 
    };
}