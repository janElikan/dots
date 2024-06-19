{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    inputs.disko.nixosModules.disko
    ./disk.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.etc."machine-id".source = "/nix/persist/identity/machine-id";
  environment.etc."ssh/ssh_host_rsa_key".source = "/nix/persist/identity/ssh/ssh_host_rsa_key";
  environment.etc."ssh/ssh_host_rsa_key.pub".source = "/nix/persist/identity/ssh/ssh_host_rsa_key.pub";
  environment.etc."ssh/ssh_host_ed25519_key".source = "/nix/persist/identity/ssh/ssh_host_ed25519_key";
  environment.etc."ssh/ssh_host_ed25519_key.pub".source = "/nix/persist/identity/ssh/ssh_host_ed25519_key.pub";

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
    shell = pkgs.nushell;
  };
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "elikan" = import ./home.nix;
    };
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

