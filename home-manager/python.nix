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

  # home.sessionPath = [ ];
  home.shellAliases = {
    "conda" = "micromamba";
  };
  # home.sessionVariables = { };

  home.packages = with pkgs; [
    # package manager
    uv

    # venv
    micromamba

    # linter/formatter
    ruff
  ];
}
