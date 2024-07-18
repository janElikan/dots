{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    #inputs.catppuccin.nixosModules.catppuccin
    /*inputs.home-manager.nixosModules.default*/
  ];

  # nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  /*
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = false;

  virtualisation.docker.enable = true;
  */

  # Never ever change this:
  system.stateVersion = "24.05";
}

