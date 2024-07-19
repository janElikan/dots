{ inputs, ... }:

{
  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
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
    settings.gui.theme = {
      activeBorderColor = [ "#a6e3a1" "bold" ];
      inactiveBorderColor = [ "#a6adc8" ];
      optionsTextColor =  [ "#89b4fa" ];
      selectedLineBgColor =  [ "#313244" ];
      cherryPickedCommitBgColor =  [ "#45475a" ];
      cherryPickedCommitFgColor =  [ "#a6e3a1" ];
      unstagedChangesColor =  [ "#f38ba8" ];
      defaultFgColor =  [ "#cdd6f4" ];
      searchingActiveBorderColor =  [ "#f9e2af" ];
      authorColors = { "*" = "#b4befe"; };
    };
  };

  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  programs.direnv.enable = true;

  programs.zellij = {
    enable = true;
    settings.theme = "catppuccin-mocha";
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

    settings.theme = "catppuccin_mocha";
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
      grep = "rg";
    };
    environmentVariables = {
      "SITE_VAULT_PATH" = "/nix/persist/active-externalism/data";
      "SITE_INCLUDE_SCOPES" = "public";
      "SITE_OUTPUT_PATH" = "/nix/persist/repos/janelikan.github.io/src/pages";
    };
  };

  programs.ripgrep.enable = true;

  # Never ever touch this:
  programs.home-manager.enable = true;
}
