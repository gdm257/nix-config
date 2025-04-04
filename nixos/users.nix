{
  inputs,
  outputs,
  globals,
  lib,
  config,
  pkgs,
  ...
}: {
  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    "${globals.username}" = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      # initialPassword = "correcthorsebatterystaple";
      # isNormalUser = true; # UID 1000+
      # isSystemUser = false; # UID <= 999
      # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      # openssh.authorizedKeys.keys = [ ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = ["wheel"];
      shell = pkgs.zsh;
      ignoreShellProgramCheck = true; # skip check because we use home-manager as nixos module
    };
  };
}
