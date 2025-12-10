{ config, pkgs, ... }:

{
  # We'll add hardware-configuration.nix import later
  
  # Boot
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  
  # Basic settings
  networking.hostName = "nixtest";
  time.timeZone = "America/Los_Angeles";
  
  # Services
  services.openssh.enable = true;
  services.tailscale.enable = true;
  
  # User
  users.users.nrm = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      # Add your SSH public key here if you want
    ];
  };
  
  # Packages
  environment.systemPackages = with pkgs; [
    helix
    git
    btop
  ];
  
  system.stateVersion = "24.05";
}