
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
}
