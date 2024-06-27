{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    inputs.catppuccin.nixosModules.catppuccin
    inputs.disko.nixosModules.disko
    inputs.impermanence.nixosModules.impermanence
    ./disk.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.persistence."/nix/persist/impermanence" = {
    hideMounts = false;
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
    users.elikan = {
      directories = [
        ".cache"
        ".mozilla"
        ".ssh"
        ".config/obsidian"
      ];
    };
  };

  networking.hostName = "honixdev0";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 22000 21027];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
  # time.timeZone = "timezones are annoying";

  users.mutableUsers = false;
  users.users.elikan = {
    isNormalUser = true;
    initialPassword = "hunter2";
    extraGroups = [ "wheel" "adbusers" "docker" ];
    shell = pkgs.nushell;
  };
  home-manager.useGlobalPkgs = true;
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "elikan" = import ./home.nix;
    };
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  hardware.pulseaudio.enable = false;
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gnome-connections
  ]) ++ (with pkgs.gnome; [
    epiphany
    geary
    evince
  ]);

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    tldr
    gnomeExtensions.pop-shell
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.adb.enable = true;

  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.ports = [ 1307 ];

  services.syncthing = {
    enable = true;
    user = "elikan";
    dataDir = "/nix/persist/sync";
    configDir = "/nix/persist/sync-config";
  };

  virtualisation.docker = {
    enable = true;
    daemon.settings.data-root = "/nix/persist/docker";
  };

  # Never ever change this:
  system.stateVersion = "24.11";
}

