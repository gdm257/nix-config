{
  lib,
  config,
  pkgs,
  ...
}: {
  virtualisation.docker = {
    enable = true;
    listenOptions = [ "/run/docker.sock" ];
    daemon.settings = {
      hosts = [ "tcp://0.0.0.0:2375" ];
    };
  };

  virtualisation.containerd = {
    enable = false;
  };

  virtualisation.cri-o = {
    enable = false;
  };
}
