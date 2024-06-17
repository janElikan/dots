{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    ./disk.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "vmnixlab0";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];
  # time.timeZone = "timezones are annoying";

  users.mutableUsers = false;
  users.users.elikan = {
    isNormalUser = true;
    initialPassword = "hunter2";
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    neovim # I'll switch to helix later
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;

  # Never ever change this:
  system.stateVersion = "24.11";
}

