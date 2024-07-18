{ inputs, ... }:

{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

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
    environmentVariables = {
      "SITE_VAULT_PATH" = "/nix/persist/active-externalism/data";
      "SITE_INCLUDE_SCOPES" = "public";
      "SITE_OUTPUT_PATH" = "/nix/persist/repos/janelikan.github.io/src/pages";
    };
  };

  catppuccin = {
    enable = true;
    accent = "green";
    flavor = "mocha";
  };

  # Never ever change these:
  home.stateVersion = "24.05"; # Please read the comment before changing.
  programs.home-manager.enable = true;
}
