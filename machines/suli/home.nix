{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../home.nix
  ];

  fonts.fontconfig.enable = true;

  home.username = "elikan";
  home.homeDirectory = "/home/elikan";

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    firefox
    discord
    chromium
    obsidian
    qjackctl # because my mic is borrowed from my phone via
    scrcpy # but it isn't recognised as a mic in the system
    pavucontrol # as a general audio panel for everything else

    (pkgs.writeShellScriptBin "rebuild" ''
      sudo nixos-rebuild switch --flake "/nix/persist/dots/#default"
    '')

    (pkgs.writeShellScriptBin "windows" ''
      sudo virsh net-start default
      sudo virsh start win10
      sleep 3s
      sudo chmod 666 /dev/shm/looking-glass
      looking-glass-client
    '')
  ];

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      package = pkgs.jetbrains-mono;
      size = 16;
    };
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          pkgs.gnomeExtensions.pop-shell.extensionUuid
        ];
      };
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      "org/gnome/mutter".experimental-features = ["scale-monitor-framebuffer"];
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };
  };
}
