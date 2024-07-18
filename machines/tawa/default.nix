{ inputs, config, lib, pkgs, ... }:

{
  environment.packages = with pkgs; [
    tldr
    openssh
    podman # because I can't run docker
  ];

  home-manager.config = import ./home.nix;
  home-manager.extraSpecialArgs = {inherit inputs;};

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
}
