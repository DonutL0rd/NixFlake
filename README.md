## how to install thingy 
--- 
clone repo
''nix build .#homeConfigurations."your.name".activationPackage''
home-manager switch --flake ~/src/nix#{home.username}