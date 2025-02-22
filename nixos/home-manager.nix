{
  inputs,
  outputs,
  globals,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = let inherit (inputs) home-manager; in [
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = false;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = {inherit inputs outputs globals;};
      home-manager.users.${globals.username} = import ./../home-manager/home.nix;
    }
  ];
}
