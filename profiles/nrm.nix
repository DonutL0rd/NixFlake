   {pkgs, ...}: {
    home.username = "nrm";
    home.homeDirectory = "/home/nrm";    
    home.stateVersion = "24.11"; # Comment out for error with "latest" version
    programs.home-manager.enable = true;
    programs.bash = {
        enable = true;
        enableCompletion = true;
        initExtra = ''
          clear
          neofetch 
          ''; 
        shellAliases = {
            ls = "eza --icons -F -H --group-directories-first --git -1";
            cat = "bat -pp";
            hmswitch = "home-manager switch --flake ~/src/nix#nrm";
        }; 
    };
}
