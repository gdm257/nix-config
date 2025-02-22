{
  lib,
  config,
  pkgs,
  ...
}: {
  home.shellAliases = {
    "conda" = "micromamba";
  };
  home.packages = with pkgs; [
    # package manager
    uv

    # venv
    micromamba

    # linter/formatter
    ruff
  ];
}
