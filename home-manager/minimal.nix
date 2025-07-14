{
  inputs,
  outputs,
  globals,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-index-database.homeModules.nix-index
    {
      programs.nix-index-database.comma.enable = true;
    }
  ];
  # programs.nix-index.enable = true; # disable if nix-index-database is used

  home.packages = with pkgs; [
    # Shell
    busybox
    uutils-coreutils-noprefix
    coreutils
    util-linux
    findutils
    xdg-utils

    # DevOps
    go-task
    uv
    bun
    rustup
    gcc
    inputs.nix-alien.packages.${globals.system}.nix-alien

    # Downloader

    # File

    # Kernel

    # Layer

    # Network
    curl
    wget
    iproute2

    # Process

    # Text
  ];

  # ==== DevOps programs ====
  programs.go = {
    enable = true;
  };

  # ==== File programs ====
  programs.eza = {
    enable = true;
    icons = "never";
    extraOptions = [ "--group-directories-first" ];
  };
  programs.fzf = {
    enable = true;
    # enableBashIntegration = false;
    # enableFishIntegration = false;
    # enableZshIntegration = false;
  };
  programs.yazi = {
    enable = true;
    settings =
      {
        manager = {
          linemode = "size";
          ratio = [1 3 3];
          show_hidden = true;
        };
        preview = {
          image_filter = "lanczos3";
        };
      }
    ;
    keymap =
      {
        input.prepend_keymap = [
          { run = "close"; on = [ "<C-q>" ]; }
        ];
      }
    ;
    theme =
      {
        flavor = { dark = "catppuccin-mocha"; light = "catppuccin-mocha"; use = "catppuccin-mocha"; };
      }
    ;
    flavors =
      let
        repo = pkgs.fetchFromGitHub {
          owner = "yazi-rs";
          repo = "flavors";
          rev = "fc8eeaab9da882d0e77ecb4e603b67903a94ee6e";
          hash = "sha256-wvxwK4QQ3gUOuIXpZvrzmllJLDNK6zqG5V2JAqTxjiY=";
        };
      in
      {
        catppuccin-frappe = repo + "/catppuccin-frappe.yazi";
        catppuccin-latte = repo + "/catppuccin-latte.yazi";
        catppuccin-macchiato = repo + "/catppuccin-macchiato.yazi";
        catppuccin-mocha = repo + "/catppuccin-mocha.yazi";
      }
    ;
  };

}
