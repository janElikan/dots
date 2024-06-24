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

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "kitty"; 

      keybindings = {
        "${modifier}+b" = "exec firefox";
        "${modifier}+t" = "exec kitty";

        "${modifier}+m" = "fullscreen toggle";
        "${modifier}+q" = "kill";
        "Mod1+Mod4+Ctrl+Shift+q" = "exec systemctl suspend";

        "${modifier}+v" = "split v";
        "${modifier}+h" = "split h";

        "${modifier}+f" = "floating toggle";
        "Mod1+Mod4+Ctrl+Shift+a" = "sticky toggle";

        "${modifier}+n" = "focus left";
        "${modifier}+e" = "focus down";
        "${modifier}+i" = "focus up";
        "${modifier}+o" = "focus right";
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";

        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";

        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
      };

      startup = [
        {command = "waybar";}
      ];

      fonts = {
        names = [ "JetBrainsMono Nerd Font" ];
        style = "Bold";
        size = 14.0;
      };

      colors = {
        focused = {
          border = "#b4befe";
          childBorder = "#b4befe";
          indicator = "#b4befe";
          text = "#cdd6f4";
          background = "#1e1e2e";
        };

        focusedInactive = {
          border = "#1e1e2e";
          childBorder = "#1e1e2e";
          indicator = "#1e1e2e";
          text = "#cdd6f4";
          background = "#1e1e2e";
        };

        unfocused = {
          border = "#1e1e2e";
          childBorder = "#1e1e2e";
          indicator = "#1e1e2e";
          text = "#cdd6f4";
          background = "#1e1e2e";
        };

        urgent = {
          border = "#fab387";
          childBorder = "#fab387";
          indicator = "#fab387";
          text = "#cdd6f4";
          background = "#1e1e2e";
        };
      };

      bars = [];

      window.titlebar = false;
    };
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [ "sway/workspaces" "sway/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "wireplumber" "cpu" "memory" ];
        "clock" = {
         format = "{:%Y-%m-%dT%H:%M}";
        };
        "wireplumber" = {
         format = " {volume} ";
         scroll-step = 5;
        };
        "cpu" = {
         format = " {} ";
        };
        "memory" = {
         format = " {} ";
        };
      };
    };
    style = ''
      * {
        font-family: JetBrainsMono Nerd Font;
        background: #1e1e2e;
        color: #cdd6f4;
        font-size: 22px;
      }
    '';
  };

  # Never ever change these:
  home.stateVersion = "24.05"; # Please read the comment before changing.
  programs.home-manager.enable = true;
}
