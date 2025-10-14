{
  inputs,
  outputs,
  globals,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # Shell
    # busybox
    # uutils-coreutils-noprefix
    # coreutils
    # util-linux
    # findutils

    # DevOps
    go-task
    # rustup
    # gcc # recommend systel level

    # Downloader

    # File
    nix-tree

    # Kernel

    # Layer
    lilipod shadow

    # Network
    curl
    wget
    iproute2

    # Process

    # Text
  ];

  # ==== DevOps programs ====
  programs.jujutsu = {
    enable = true;
  };
  programs.uv = {
    enable = true;
  };
  programs.bun = {
    enable = true;
  };
  # programs.go = {
  #   enable = true;
  # };

  # ==== DevOps programs ====
  programs.distrobox = {
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
    package = pkgs.go-task; # Placeholder pkg to reduce size. Install bin manually
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
          rev = "f6b425a6d57af39c10ddfd94790759f4d7612332";
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
