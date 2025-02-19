{
  inputs,
  outputs,
  globals,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # Run the Proxmox Hypervisor on top of NixOS
    inputs.proxmox-nixos.nixosModules.promox-ve

    # FIXME
    # An inline NixOS module to configure promox
    (
      { pkgs, lib, ... }: {
        services.promox-ve = {
          enable = true;
          ipAddress = "192.168.0.1";
        };
        nixpkgs.overlays = [
          inputs.proxmox-nixos.overlays.${globals.system}
        ];
      }
    )
  ];
}
