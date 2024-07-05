{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  home.username = "elikan";
  home.homeDirectory = "/home/elikan";
  fonts.fontconfig.enable = true;

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
  ];

  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
  };

  home.sessionVariables = {
  };

  programs.git = {
    enable = true;
    userName = "jan Elikan";
    userEmail = "janelikan@proton.me";
  };

  programs.lazygit = {
    enable = true;
    settings.notARepository = "quit";
    settings.disableStartupPopups = true;
    settings.gui.nerdFontsVersion = "3";
    settings.gui.authorColors."jan Elikan" = "green";
  };

  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  programs.direnv.enable = true;

  programs.zellij = {
    enable = true;
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings.editor = {
      true-color = true;
      line-number = "relative";
      color-modes = true;
      indent-guides.render = false;
    };
  };

  programs.nushell = {
    enable = true;
    envFile.text = ''
    '';
    configFile.text = ''
      $env.config = {
        show_banner: false,
      }
    '';
    shellAliases = {
      lg = "lazygit";
    };
  };

  catppuccin = {
    enable = true;
    accent = "green";
    flavor = "mocha";
  };

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

  # Never ever change these:
  home.stateVersion = "24.05"; # Please read the comment before changing.
  programs.home-manager.enable = true;
}
