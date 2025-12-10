## how to install thingy 
--- 
clone repo

nix build .#homeConfigurations."your.name".activationPackage

mv ~/.bashrc ~./backupbashrc # to make sure you are keeping a backup of bashrc and profile before it may get deleted in the next step
./result/activate

home-manager switch --flake ~/src/nix#{home.username}
