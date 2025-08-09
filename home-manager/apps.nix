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

  # ==== Layer programs ====
  programs.distrobox = {
    enable = true;
  };

  # ==== Process programs ====
  programs.htop.enable = true;
}
