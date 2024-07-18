{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  home-manager.useGlobalPkgs = true;
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "elikan" = import ./home.nix;
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = false;

  virtualisation.docker.enable = true;

  # Never ever change this:
  system.stateVersion = "24.11";
}

