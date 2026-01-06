{
  description = "Home Manager and NixOS";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = {self, nixpkgs, home-manager, ...}: {
    # Your existing Home Manager configs
    homeConfigurations = {
      "benjamincurrie" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config.allowUnfree = true;
        };
        modules = [ ./shell.nix ./profiles/benjamincurrie.nix ];
      };
      "nrm" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        modules = [ ./shell.nix ./profiles/nrm.nix ];
      };
    };
    
    # NEW: NixOS system configuration
    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";  # M4 Mac = ARM
      modules = [
        ./hosts/m4virt.nix
        # Optional: integrate Home Manager into NixOS
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.benjamincurrie = import ./shell.nix;  # or create a new VM-specific profile
        }
      ];
    };
  };
}
