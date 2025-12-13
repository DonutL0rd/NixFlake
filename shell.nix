{pkgs, lib, config, ...}: {
  imports = [
    ./appConfigs/nvim.nix
    ./appConfigs/starship.nix
  ];
  home.packages = [
    pkgs.nixfmt-rfc-style
    pkgs.cowsay
    pkgs.starship
    pkgs.github-cli
    pkgs.btop
    pkgs.gemini-cli
    pkgs.tailscale
    pkgs.gping
    pkgs.neofetch
  ];
  

}
