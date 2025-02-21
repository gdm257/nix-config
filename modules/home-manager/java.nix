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
  # home.sessionPath = [ ];
  # home.sessionVariables = { };
  # home.shellAliases = { };

  home.packages = with pkgs; [
    # sdk
    jbang

    # package manager
    maven

    # android
    android-tools
    apk-tool
  ];

  # package manager
  programs.gradle.enable = true;
}
