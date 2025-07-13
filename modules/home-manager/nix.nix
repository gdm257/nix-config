{
  globals,
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    nix-derivation
    nix-init
    nix-tree
    # nix-du
    nix-visualize
    nixpacks
    nixos-generators
    nixos-shell
    niv
    nurl
    nvd
    disko
    extra-container
  ];
}
