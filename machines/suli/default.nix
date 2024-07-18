{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
    inputs.disko.nixosModules.disko
    inputs.impermanence.nixosModules.impermanence
    ./disk.nix
    ./hardware-configuration.nix
  ];

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
    directories = [
      "/var/lib/libvirt"
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

  networking.hostName = "suli";
  networking.networkmanager.enable = true;

  # syncthing ports
  networking.firewall.allowedTCPPorts = [ 22000 21027];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];

  users.mutableUsers = false;
  users.users.elikan = {
    isNormalUser = true;
    initialPassword = "hunter2";
    extraGroups = [ "wheel" "adbusers" "docker" "libvirtd" ];
    shell = pkgs.nushell;
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
    epiphany
    geary
    evince
  ]);

  environment.systemPackages = with pkgs; [
    tldr
    gnomeExtensions.pop-shell
    looking-glass-client
    inputs.site-builder.defaultPackage.x86_64-linux
  ];

  programs.adb.enable = true;

  services.syncthing = {
    enable = true;
    user = "elikan";
    dataDir = "/nix/persist/sync";
    configDir = "/nix/persist/sync-config";
  };

  virtualisation.docker.daemon.settings.data-root = "/nix/persist/docker";

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;
      runAsRoot = true;
      ovmf = {
        enable = true;
        packages = [(pkgs.OVMF.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd];
      };
    };
  };
  programs.virt-manager.enable = true;
}

