{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../home.nix
  ];

  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts = {
    serif = [ "Noto Serif" "Source Han Serif" ];
    sansSerif = [ "Noto Sans" "Source Han Sans" ];
  };

  home.username = "elikan";
  home.homeDirectory = "/home/elikan";

  home.packages = with pkgs; [
    # fonts
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    font-awesome

    # desktop apps
    xwaylandvideobridge # for discord
    firefox
    chromium
    obsidian
    qjackctl # because my mic is borrowed from my phone via
    scrcpy # but it isn't recognised as a mic in the system
    pavucontrol # as a general audio panel for everything else
    swaybg

    (pkgs.writeShellScriptBin "rebuild" ''
      sudo nixos-rebuild switch --flake "/nix/persist/repos/dots/#suli"
    '')

    (pkgs.writeShellScriptBin "microphone" ''
      scrcpy --audio-source=mic
    '')

    (pkgs.writeShellScriptBin "windows" ''
      sudo virsh net-start default
      sudo virsh start win10
      sleep 3s
      sudo chmod 666 /dev/shm/looking-glass
      looking-glass-client
    '')
  ];

  programs.librewolf = {
    enable = true;
    settings."webgl.disabled" = false;
  };

  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    font = {
      name = "JetBrainsMono Nerd Font";
      package = pkgs.jetbrains-mono;
      size = 16;
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";

      menu = "tofi-run | xargs swaymsg exec --";
      defaultWorkspace = "workspace number 5";
      assigns = {
        # all found through `swaymsg -t get_tree`
        "1" = [
          { class = "QjackCtl"; }
          { class = ".scrcpy-wrapped"; }
          { class = "xwaylandvideobridge"; }
        ];

        "5" = [{ app_id = "obsidian"; }];
        "6" = [{ app_id = "firefox"; }];

        "10" = [{ app_id = "looking-glass-client"; }];
      };
      startup = [
        { command = "swaybg -i /nix/persist/repos/dots/wallpaper.svg -m fill"; }
        { command = "firefox"; }
        { command = "obsidian"; }
        { command = "xwaylandvideobridge"; }
      ];

      window.titlebar = false;
      bars = [];
      colors = {
        focused = { border = "#a6e3a1"; childBorder = "#a6e3a1"; background = "#1e1e2e"; text = "#cdd6f4"; indicator = "#a6e3a1"; };
        focusedInactive = { border = "#1e1e2e"; childBorder = "#1e1e2e"; background = "#1e1e2e"; text = "#cdd6f4"; indicator = "#1e1e2e"; };
        unfocused = { border = "#1e1e2e"; childBorder = "#1e1e2e"; background = "#1e1e2e"; text = "#cdd6f4"; indicator = "#1e1e2e"; };
        urgent = { border = "#f38ba8"; childBorder = "#f38ba8"; background = "#1e1e2e"; text = "#cdd6f4"; indicator = "#f38ba8"; };
      };
      seat = {
        "*" = {
          # hide_cursor = "when-typing enable";
          xcursor_theme = "catppuccin-mocha-dark-cursors";
        };
      };
    };
    wrapperFeatures.gtk = true;
  };

  programs.tofi = {
    enable = true;
    settings = {
      background-color = "#1e1e2e";
      text-color = "#cdd6f4";
      prompt-color = "#b4befe";
      selection-color = "#a6e3a1";
      font = "JetBrainsMono Nerd Font";
      border-width = 0;
      outline-width = 0;
      corner-radius = 16;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    name = "catppuccin-mocha-dark-cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 64;
    x11.enable = true;
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

  # Never ever change these:
  home.stateVersion = "24.05"; # Please read the comment before changing.
}
