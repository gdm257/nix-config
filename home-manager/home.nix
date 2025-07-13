# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  globals,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # Or modules your own flake exports (from modules/home-manager):
    outputs.homeManagerModules.vim
    # outputs.homeManagerModules.nix

    # You can also split up your configuration and import pieces of it here:
    ./editorconfig.nix
    ./shell.nix

    ./minimal.nix
    # ./apps.nix

    (if globals.isDesktop then inputs.nix-flatpak.homeManagerModules.nix-flatpak else {})
    (if globals.isDesktop then ./flatpak.nix else {})
    (if globals.isDesktop && globals.isSteamDeck then ./steamdeck.nix else {})
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

  home = {
    username = globals.username;
    homeDirectory = globals.home;
  };

  # Enable home-manager and git
  home.packages = [ pkgs.home-manager ];
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
