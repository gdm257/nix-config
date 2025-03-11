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
    # DevOps
    bit
    gitui
    gitu
    elfutils
    elfkickers
    elf-info
    go-task
    devbox
    devspace
    devpod

    # Downloader
    croc
    rclone

    # File
    age
    duf
    dust
    fd
    lvm2_vdo
    btrfs-progs

    # Kernel
    fastfetch

    # Layer
    cntr
    containerlab
    ctop
    lazydocker
    kompose
    helm
    k3d
    k9s
    krew
    kubectx
    velero
    # libguestfs # too large

    # Network
    bandwhich
    curl
    wget
    doggo
    gping
    iproute2
    caddy inputs.localias.packages.${globals.system}.default

    # Process
    htop
    pstree
    systemd
    libcgroup

    # Shell
    firejail
    mosh
    openssh
    powershell
    rargs
    util-linux
    uutils-coreutils
    uutils-coreutils-noprefix
    wsl-open
    xdg-utils

    # Text
    jq
    ripgrep
    sad
    yq
  ];

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

  # ==== Process programs ====
  programs.htop.enable = true;
}
