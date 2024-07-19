{ inputs, config, lib, pkgs, ... }:

{
  environment.packages = with pkgs; [
    tldr
    w3m
    openssh
    podman # because I can't run docker
  ];

  android-integration.termux-setup-storage.enable = true;

  terminal.font = "${ pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; } }/share/fonts/truetype/NerdFonts/JetBrainsMonoNerdFont-Medium.ttf";
  terminal.colors = {
    background = "#1e1e2e";
    foreground = "#cdd6f4";
    cursor = "#cdd6f4";
    color0 = "#45475a";
    color8 = "#585b70";
    color1 = "#f38ba8";
    color9 = "#f38ba8";
    color2  = "#a6e3a1";
    color10 = "#a6e3a1";
    color3  = "#f9e2af";
    color11 = "#f9e2af";
    color4  = "#89b4fa";
    color12 = "#89b4fa";
    color5  = "#f5c2e7";
    color13 = "#f5c2e7";
    color6  = "#94e2d5";
    color14 = "#94e2d5";
    color7  = "#bac2de";
    color15 = "#a6adc8";
  };

  home-manager.config = import ./home.nix;
  home-manager.extraSpecialArgs = {inherit inputs;};

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.stateVersion = "24.05";
}
