# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # TODO: Set your username
  home = {
    username = "root";
    homeDirectory = "/root";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    # DevOps
    bit
    gitui
    gitu

    # Downloader
    croc
    rclone

    # File
    age
    duf
    fd

    # Network
    curl
    wget
    gping
    iproute2

    # Process
    pstree
    systemd
    systemctl-tui

    # Shell
    firejail
    mosh
    openssh
    powershell
    rargs
    uutils-coreutils
    uutils-coreutils-noprefix
    wsl-open
    xdg-utils

    # Text
    ripgrep
    sad
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # File programs
  programs.eza = {
    enable = true;
    icons = "never";
    extraOptions = [ "--group-directories-first" ];
  };
  programs.fzf = {
    enable = true;
  };
  programs.yazi = {
    # TODO: issue nix-community/home-manager#6273
    enable = true;
    settings =
      {
        manager = {
          show_hidden = true;
          sort_dir_first = true;
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
        flavor = { dark = "catppuccin-mocha"; light = "catppuccin-macchiato"; };
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

  # Process programs
  programs.htop.enable = true;

  # Shell programs
  programs.bash = {
    enable = true;
    historySize = 70000;
    historyIgnore = [
      "cd"
      "clear"
      "exit"
      "ls"
      "pwd"
    ];
    sessionVariables = { };
    shellAliases = {
      z = "zoxide";
    };
    profileExtra = "";
    initExtra = "";
    bashrcExtra = "";
    logoutExtra = "";
  };
  programs.zsh = {
    enable = true;
    autocd = false;
    cdpath = [ ];
    dotDir = null;
    shellAliases = {
      z = "zoxide";
    };
    shellGlobalAliases = { };
    dirHashes = {
      docs = "$HOME/Documents";
      vids = "$HOME/Videos";
      dl = "$HOME/Downloads";
    };
    zprof.enable = false;
    autosuggestion = {
      enable = true;
      strategy = [
        "history"
        # "completion"
        # "match_prev_cmd"
      ];
    };
    defaultKeymap = null; # "emacs" "viins" "vicmd"
    sessionVariables = { };
    initExtraBeforeCompInit = "";
    initExtra = "";
    initExtraFirst = "";
    envExtra = "";
    profileExtra = "";
    loginExtra = "";
    logoutExtra = "";
    localVariables = { };
    plugins = [ ];
    oh-my-zsh = { };
  };
  programs.man.enable = true;
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      character.success_symbol = "[>](bold green)";
      directory.truncation_length = 0;
      directory.use_os_path_sep = false;
      directory.style = "bold #edc809";
      username.style_user = "green";
      username.style_root = "green";
      username.format = "[\$user](\$style)";
      username.disabled = false;
      username.show_always = true;
      hostname.ssh_only = false;
      hostname.format = "[\$ssh_symbol](bold blue)[@\$hostname](green) ";
      hostname.disabled = false;
      status.style = "red bold";
      status.symbol = "🔴";
      status.success_symbol = "🟢";
      status.format = "[\$symbol\$signal_name\$maybe_int](\$style)";
      status.map_symbol = true;
      status.disabled = false;
      battery.full_symbol = "🔋 ";
      battery.charging_symbol = "⚡️ ";
      battery.discharging_symbol = "💀 ";
      battery.display = [
        {
          threshold = 50;
          style = "bold red";
        }
      ];
    };
  };
  programs.zellij.enable = true;
  programs.zoxide.enable = true;

  # Text programs
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
