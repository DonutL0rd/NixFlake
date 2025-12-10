{pkgs, ...}: {
       # Add this somewhere in `home.nix`
    home.packages = [
        pkgs.nixfmt-rfc-style
        pkgs.cowsay
        pkgs.starship
    ];

    programs.starship = {
        enable = true;
        enableZshIntegration = true;
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