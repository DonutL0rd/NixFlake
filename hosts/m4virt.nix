{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "m4NixosVirt";
  networking.networkmanager.enable = true;

  # Time zone
  time.timeZone = "America/New_York";  # change to yours

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
  ];

  # User account
  users.users.yourname = {  # replace with your actual username
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "changeme";  # set a real password after first boot
  };

  # Enable sudo for wheel group
  security.sudo.wheelNeedsPassword = true;

  # SSH (optional, useful for VM access)
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";

  # Don't change this
  system.stateVersion = "24.05";  # match whatever the installer gave you
}
