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
    [ ! -f "$HOME/.x-cmd.root/X" ] || . "$HOME/.x-cmd.root/X" && [ -f "$HOME/.nix-profile/bin/," ] && unalias ,;
  '';
in
{
  home.shellAliases = {
    ".." = "cd ..";
    "..." = "cd ../..";
  };
  home.sessionVariables = {
    HOMEBREW_PREFIX =
      let
        isLinux = pkgs.stdenv.isLinux;
        isDarwin = pkgs.stdenv.isDarwin;
        isAarch64 = pkgs.stdenv.isAarch64; # Apple Silicon
      in
        if isDarwin then
          if isAarch64 then "/opt/homebrew"
          else "/usr/local"
        else "/home/linuxbrew/.linuxbrew";
  };
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.bun/bin"
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
      ${init_extra}
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
    initContent =
      let
        _initExtraFirst = lib.mkOrder 500 ''
        '';
        _initExtraBeforeCompInit = lib.mkOrder 550 ''
        '';
        _initExtra = lib.mkOrder 1000 ''
          ${init_extra}

          # Prompt
          _zsh_auto_shorten_path() {
            local min_length=20
            local max_length=$(( COLUMNS * 60 / 100 ))
            local current_path="$(eval 'print -P "%~"')"
            local current_length=''${#current_path} # nix escape
            if (( COLUMNS < min_length )); then
              echo "%1~"
            elif (( current_length > max_length )); then
              echo "%(4~|%-1~/…/%2~|%~)"
            else
              echo "$1"
            fi
          }
          setopt prompt_subst
          _zsh_update_prompt() {
            PS1='
          %F{#3465A4}┌──(%f%F{#AD7FA8}%n㉿%m%f%F{#3465A4}%)-[%f%F{yellow}$(_zsh_auto_shorten_path "%~")%f%F{#3465A4}]%f
          %F{#3465A4}└──%f%(?.🟢 %F{#16C60C}%(!.#.>)%f.🔴 %F{red}%(!.#.>)%f) '
          }
          add-zsh-hook precmd _zsh_update_prompt
        '';
        _initMkAfeter = lib.mkOrder 1500 ''
        '';
      in
        lib.mkMerge [ _initExtraFirst _initExtraBeforeCompInit _initExtra _initMkAfeter ]
    ;
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
        # "prompt"
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
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    settings =
      {
        mgr = {
          linemode = "size";
          ratio = [1 3 3];
          show_hidden = true;
        };
        preview = {
          image_filter = "lanczos3";
        };
      }
    ;
    keymap =
      {
        input.prepend_keymap = [
          { run = "close"; on = [ "<C-q>" ]; }
        ];
      }
    ;
    theme =
      {
        flavor = { dark = "catppuccin-mocha"; light = "catppuccin-mocha"; use = "catppuccin-mocha"; };
      }
    ;
    flavors =
      let
        repo = pkgs.fetchFromGitHub {
          owner = "yazi-rs";
          repo = "flavors";
          rev = "f6b425a6d57af39c10ddfd94790759f4d7612332";
          hash = "sha256-wvxwK4QQ3gUOuIXpZvrzmllJLDNK6zqG5V2JAqTxjiY=";
        };
      in
      {
        catppuccin-frappe = repo + "/catppuccin-frappe.yazi";
        catppuccin-latte = repo + "/catppuccin-latte.yazi";
        catppuccin-macchiato = repo + "/catppuccin-macchiato.yazi";
        catppuccin-mocha = repo + "/catppuccin-mocha.yazi";
      }
    ;
  };
  programs.zellij.enable = true;
  programs.zoxide.enable = true;
  programs.zoxide.enableBashIntegration = true;
  programs.zoxide.enableFishIntegration = true;
  programs.zoxide.enableNushellIntegration = true;
  programs.zoxide.enableZshIntegration = true;
}
