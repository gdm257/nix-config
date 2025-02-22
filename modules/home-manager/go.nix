{
  lib,
  config,
  pkgs,
  ...
}: {
  programs.go = {
    enable = true;
  };
  home.packages = with pkgs; [
    golangci-lint
    goreleaser
    protoc-gen-go
  ];
}
