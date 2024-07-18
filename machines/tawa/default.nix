{ inputs, config, lib, pkgs, ... }:

{
  environment.packages = with pkgs; [
    tldr
    openssh
  ];

  home-manager.config = import ./home.nix;
  home-manager.extraSpecialArgs = {inherit inputs;};
}
