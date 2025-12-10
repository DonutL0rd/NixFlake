{pkgs, ...}: {
       # Add this somewhere in `home.nix`
    home.packages = [
        pkgs.nixfmt-rfc-style
        pkgs.cowsay
        pkgs.starship
        pkgs.github-cli
    ];

    programs.starship = {
        enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;
    };
} 