{
    description = "Home Manager";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {self, nixpkgs, home-manager, ...}: {
        homeConfigurations = {
            "benjamincurrie" = home-manager.lib.homeManagerConfiguration {
                # System is very important!
                pkgs = import nixpkgs { system = "aarch64-darwin"; };

                modules = [ ./shell.nix ./profiles/benjamincurrie.nix]; # Defined later
            };
            "nrm" = home-manager.lib.homeManagerConfiguration {
                # System is very important!
                pkgs = import nixpkgs { system = "x86_64-linux"; };

                modules = [ ./shell.nix ./profiles/nrm.nix]; # Defined later
            };
        };
    };
}