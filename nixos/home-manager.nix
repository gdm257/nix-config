{
  globals,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = {inherit inputs outputs globals;};
      home-manager.users.${globals.username} = import ./../home-manager/home.nix;
    }
  ];
}
