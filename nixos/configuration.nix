# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  globals,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # TODO: Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # Or modules from your own flake exports (from modules/nixos):
    # outputs.nixosModules.my-module

    # You can also split up your configuration and import pieces of it here:
    ./nixpkgs.nix
    ./nix.nix
    ./promox.nix
    ./ssh.nix
  ];

  # FIXME: Add the rest of your current configuration

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}
