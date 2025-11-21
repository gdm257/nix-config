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
    file
    lvm2_vdo
    btrfs-progs

    # Kernel
    fastfetch

    # Layer
    podman passt shadow # rootless
    cntr
    containerlab
    ctop
    lazydocker
    kompose
    kubernetes-helm
    helmfile
    k3sup
    k3d
    k9s
    krew
    kubectx
    velero
    # libguestfs # too large

    # Network
    bandwhich
    doggo
    gping
    caddy inputs.localias.packages.${globals.system}.default

    # Process
    pstree
    systemd
    libcgroup

    # Shell
    busybox
    uutils-coreutils-noprefix
    coreutils
    util-linux
    findutils

    firejail
    mosh
    openssh
    powershell
    wsl-open
    xdg-utils

    # Text
    jq
    ripgrep
    sad
    yq
  ];

  # ==== DevOps programs ====
  programs.git.enable = true;

  # ==== File programs ====
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

  # ==== Process programs ====
  programs.htop.enable = true;
}
