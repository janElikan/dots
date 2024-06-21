{ config, pkgs, ... }:

{
  home.username = "elikan";
  home.homeDirectory = "/home/elikan";

  home.packages = [
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

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

  programs.zellij = {
    enable = true;
    settings.theme = "catppuccin-mocha";
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings.theme = "catppuccin_mocha";
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

  # Never ever change these:
  home.stateVersion = "24.05"; # Please read the comment before changing.
  programs.home-manager.enable = true;
}
