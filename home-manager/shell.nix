{
  inputs,
  outputs,
  globals,
  lib,
  config,
  pkgs,
  ...
}:
let
  init_extra = ''
    [ ! -f "$HOMEBREW_PREFIX/bin/brew" ] || eval "$($HOMEBREW_PREFIX/bin/brew shellenv)";
  '';
in
{
  home.shellAliases = {
    ".." = "cd ..";
    "..." = "cd ../..";
  };
  home.sessionVariables = {
    HOMEBREW_PREFIX = "/home/linuxbrew/.linuxbrew";
  };
  home.sessionPath = [
    "${config.home.sessionVariables.HOMEBREW_PREFIX}/bin"
    "${config.home.sessionVariables.HOMEBREW_PREFIX}/sbin"
  ];

  # ==== Shell programs ====
  programs.bash = {
    enable = true;
    historySize = 70000;
    historyIgnore = [
      "cd"
      "clear"
      "exit"
      "ls"
      "pwd"
    ];
    sessionVariables = { };
    shellAliases = { };
    profileExtra = "";
    initExtra = ''
      ${init_extra};
      [ ! -f "$HOME/.x-cmd.root/X" ] || . "$HOME/.x-cmd.root/X";
    '';
    bashrcExtra = "";
    logoutExtra = "";
  };
  programs.zsh = {
    enable = true;
    autocd = false;
    cdpath = [ ];
    dotDir = null;
    shellAliases = { };
    shellGlobalAliases = { };
    dirHashes = {
      docs = "$HOME/Documents";
      vids = "$HOME/Videos";
      dl = "$HOME/Downloads";
    };
    zprof.enable = false;
    autosuggestion = {
      enable = true;
      strategy = [
        "history"
        "completion"
        # "match_prev_cmd"
      ];
    };
    history = {
      save = 65536;
    };
    defaultKeymap = null; # "emacs" "viins" "vicmd"
    sessionVariables = { };
    initExtraBeforeCompInit = "";
    initExtra = ''
      ${init_extra};
    '';
    initExtraFirst = "";
    envExtra = "";
    profileExtra = "";
    loginExtra = "";
    logoutExtra = "";
    localVariables = { };
    plugins = [ ];
    oh-my-zsh = { };
    prezto = {
      enable = true;
      caseSensitive = false;
      editor.keymap = "vi"; # vi | emacs
      prompt.theme = "peepcode"; # peepcode | adam2 | adam1
      prompt.pwdLength = "long"; # short | long | full
      prompt.showReturnVal= true;
      syntaxHighlighting.highlighters = [
        "main"
        "brackets"
        "pattern"
        "line"
        "cursor"
        "root"
      ];
      pmodules = [
        "environment"
        "terminal"
        "editor"
        "history"
        "directory"
        "spectrum"
        "archive"
        "docker"
        # "utility" # bug: mkdir
        # "completion" # too slow
        "prompt"
      ];
      # extraModules = [ ];
      # extraFunctions = [ ];
    };
  };
  programs.man.enable = true;
  programs.starship = {
    enable = true;
    enableZshIntegration = false;
    settings = {
      add_newline = true;
      character.success_symbol = "[>](bold green)";
      directory.truncation_length = 10;
      directory.use_os_path_sep = false;
      directory.style = "bold #edc809";
      username.style_user = "green";
      username.style_root = "green";
      username.format = "[\$user](\$style)";
      username.disabled = false;
      username.show_always = true;
      hostname.ssh_only = false;
      hostname.format = "[\$ssh_symbol](bold blue)[@\$hostname](green) ";
      hostname.disabled = false;
      status.style = "red bold";
      status.symbol = "🔴 ";
      status.success_symbol = "🟢 ";
      status.format = "[\$symbol\$signal_name\$maybe_int](\$style)";
      status.map_symbol = true;
      status.disabled = false;
      battery.full_symbol = "🔋 ";
      battery.charging_symbol = "⚡️ ";
      battery.discharging_symbol = "💀 ";
      battery.display = [
        {
          threshold = 50;
          style = "bold red";
        }
      ];
    };
  };
  programs.zellij.enable = true;
  programs.zoxide.enable = true;
}
