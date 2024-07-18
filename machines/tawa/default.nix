{ config, lib, pkgs, ... }

{
  environment.packages = with pkgs; [
    vim
    tldr
  ];
}
