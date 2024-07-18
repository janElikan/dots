
{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../home.nix
  ];

  home.packages = with pkgs; [
    (pkgs.writeShellScriptBin "rebuild" ''
      nix-on-droid switch --flake ~/dots#tawa
    '')
  ];

  # Never ever change these:
  home.stateVersion = "24.05"; # Please read the comment before changing.
}
