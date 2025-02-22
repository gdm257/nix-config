{
  inputs,
  outputs,
  globals,
  lib,
  config,
  pkgs,
  ...
}: {
  # Run the Proxmox Hypervisor on top of NixOS
  imports = let inherit inputs; in [
    inputs.proxmox-nixos.nixosModules.proxmox-ve
    # FIXME
    (
      { inputs, pkgs, lib, ... }: {
        services.proxmox-ve = {
          enable = true;
          ipAddress = "192.168.0.1";
        };
        nixpkgs.overlays =[
          inputs.proxmox-nixos.overlays.${globals.system}
        ];
      }
    )
  ];
}
