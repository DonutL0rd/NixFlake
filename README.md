## how to install thingy 
--- 
clone repo

nix build .#homeConfigurations."your.name".activationPackage

./result/activate

home-manager switch --flake ~/src/nix#{home.username}
