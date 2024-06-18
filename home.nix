{ config, pkgs, ... }:

{
  home.username = "elikan";
  home.homeDirectory = "/home/elikan";

  home.packages = [
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # (pkgs.writeShellScriptBin "rebuild" ''
    #   sudo nixos-rebuild switch --flake "/nix/persist/dots/#default"
    # '')
  ];

  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.git = {
    enable = true;
    userName = "jan Elikan";
    userEmail = "janelikan@proton.me";
  };

  # Never ever change these:
  home.stateVersion = "24.05"; # Please read the comment before changing.
  programs.home-manager.enable = true;
}
