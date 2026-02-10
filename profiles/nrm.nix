{pkgs, ...}: {
  home.username = "nrm";
  home.homeDirectory = "/home/nrm";
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      clear
      fastfetch
    '';
    shellAliases = {
      hmswitch = "home-manager switch --flake ~/src/nix#nrm";
    };
  };
}
