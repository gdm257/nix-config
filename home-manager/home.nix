# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # TODO: Set your username
  home = {
    username = "root";
    homeDirectory = "/root";
  };

  home.sessionPath = [ ];
  home.shellAliases = {
    z = "zoxide";
  };
  home.sessionVariables = { };
  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line=  "lf";
        trim_trailing_whitespace = true;
        indent_style = "space";
        # indent_size= 4;
        # insert_final_newline = true;
      };
    };
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    # DevOps
    bit
    gitui
    gitu

    # Downloader
    croc
    rclone

    # File
    age
    duf
    fd

    # Network
    curl
    wget
    gping
    iproute2

    # Process
    pstree
    systemd
    systemctl-tui

    # Shell
    firejail
    mosh
    openssh
    powershell
    rargs
    uutils-coreutils
    uutils-coreutils-noprefix
    wsl-open
    xdg-utils

    # Text
    ripgrep
    sad
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # File programs
  programs.eza = {
    enable = true;
    icons = "never";
    extraOptions = [ "--group-directories-first" ];
  };
  programs.fzf = {
    enable = true;
  };
  programs.yazi = {
    # TODO: issue nix-community/home-manager#6273
    enable = true;
    settings =
      {
        manager = {
          show_hidden = true;
          sort_dir_first = true;
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
        flavor = { dark = "catppuccin-mocha"; light = "catppuccin-macchiato"; };
      }
    ;
    flavors =
      let
        repo = pkgs.fetchFromGitHub {
          owner = "yazi-rs";
          repo = "flavors";
          rev = "fc8eeaab9da882d0e77ecb4e603b67903a94ee6e";
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

  # Process programs
  programs.htop.enable = true;

  # Shell programs
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
    initExtra = "";
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
        # "completion"
        # "match_prev_cmd"
      ];
    };
    defaultKeymap = null; # "emacs" "viins" "vicmd"
    sessionVariables = { };
    initExtraBeforeCompInit = "";
    initExtra = "";
    initExtraFirst = "";
    envExtra = "";
    profileExtra = "";
    loginExtra = "";
    logoutExtra = "";
    localVariables = { };
    plugins = [ ];
    oh-my-zsh = { };
  };
  programs.man.enable = true;
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      character.success_symbol = "[>](bold green)";
      directory.truncation_length = 0;
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
      status.symbol = "🔴";
      status.success_symbol = "🟢";
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

  # Text programs
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      # Assembly
      dan-c-underwood.arm
      13xforever.language-x86-64-assembly

      # C/C++
      bbenoist.doxygen
      cschlosser.doxdocgen
      jeff-hykin.better-cpp-syntax
      xaver.clang-format
      llvm-vs-code-extensions.vscode-clangd
      ms-vscode.cmake-tools
      twxs.cmake
      vadimcn.vscode-lldb
      ms-vscode.makefile-tools
      tboox.xmake-vscode

      # Rust
      fill-labs.dependi
      rust-lang.rust-analyzer
      vadimcn.vscode-lldb

      # Go
      golang.go
      xiaoxin-technology.goctl

      # Web - JS/TS/CSS/HTML
      anbuselvanrocky.bootstrap5-vscode
      antfu.iconify
      astro-build.astro-vscode
      bradlc.vscode-tailwindcss
      aaravb.chrome-extension-developer-tools
      burkeholland.simple-react-snippets
      christian-kohler.npm-intellisense
      christian-kohler.path-intellisense
      cipchk.cssrem
      dbaeumer.vscode-eslint
      donjayamanne.jquerysnippets
      AbhiPatel.jquery-snippets
      dsznajder.es7-react-js-snippets
      ecmel.vscode-html-css
      esbenp.prettier-vscode
      firefox-devtools.vscode-firefox-debug
      hollowtree.vue-snippets
      mariusschulz.yarn-lock-syntax
      ms-vscode.live-server
      ritwickdey.LiveServer
      msjsdiag.vscode-react-native
      octref.vetur
      otovo-oss.htmx-tags
      pcbowers.alpine-intellisense
      pranaygp.vscode-css-peek
      rvest.vs-code-prettier-eslint
      humao.rest-client
      sdras.vue-vscode-snippets
      Orta.vscode-jest
      vue.volar
      # wallabyjs.quokka-vscode
      xabikos.JavaScriptSnippets
      zignd.html-css-class-completion
      yoavbls.pretty-ts-errors
      youngjuning.yarn-lock-preview
      zxh404.vscode-proto

      # JVM - Java/Kotlin/Scala/Clojure
      betterthantomorrow.calva-spritz
      betterthantomorrow.calva
      vscjava.vscode-java-pack
      fwcd.kotlin
      scalameta.metals
      scala-lang.scala
      SonarSource.sonarlint-vscode
      vmware.vscode-boot-dev-pack

      # Lua
      sumneko.lua
      actboy168.lua-debug

      # Matlab
      affenwiesel.matlab-formatter
      apommel.matlab-interactive-terminal
      bat67.matlab-extension-pack

      # Lisp
      mattn.Lisp

      # .NET - C#/F#/PowerShell
      ms-dotnettools.vscodeintellicode-csharp
      Ionide.Ionide-fsharp
      ms-vscode.PowerShell
      ms-dotnettools.dotnet-interactive-vscode

      # PHP
      zobo.php-intellisense
      xdebug.php-debug
      xdebug.php-pack

      # Python
      ms-python.python
      ms-python.vscode-pylance
      ms-python.debugpy
      njpwerner.autodocstring
      rodolphebarbanneau.python-docstring-highlighter
      seanwu.vscode-qt-for-python
      EricSia.pythonsnippets3
      "076923".python-image-preview
      batisteo.vscode-django
      junstyle.vscode-django-support
      samuelcolvin.jinjahtml
      battlebas.kivy-vscode
      ms-toolsai.jupyter
      ms-python.mypy-type-checker
      charliermarsh.ruff
      ms-python.vscode-python-envs

      # DevOps
      redhat.ansible
      mrmlnc.vscode-apache
      ahmadalli.vscode-nginx-conf
      raynigon.nginx-formatter
      eiminsasete.apacheconf-snippets
      thqby.vscode-autohotkey2-lsp
      rogalmic.bash-debug
      mads-hartmann.bash-ide-vscode
      jeff-hykin.better-dockerfile-syntax
      jeff-hykin.better-shellscript-syntax
      samuelcolvin.jinjahtml
      mindaro.mindaro
      matthewpi.caddyfile-support
      formulahendry.code-runner
      ms-azuretools.vscode-docker
      p1c2u.docker-compose
      exiasr.hadolint
      Maarti.jenkins-doc
      ivory-lab.jenkinsfile-support
      ms-kubernetes-tools.vscode-kubernetes-tools
      berublan.vscode-log-viewer
      xshrim.txt-syntax
      meronz.manpages
      okteto.remote-kubernetes
      asciidoctor.asciidoctor-vscode
      tetradresearch.vscode-h2o
      woozy-masta.shell-script-ide
      foxundermoon.shell-format
      timonwong.shellcheck
      Remisa.shellman
      hangxingliu.vscode-systemd-support
      bbenoist.vagrant
      marcostazi.VS-code-vagrantfile

      # ==== Common ====

      # AI
      codeium.codeium
      # GitHub.copilot
      # GitHub.copilot-chat
      # Codium.codium
      # AMiner.codegeex
      # DanielSanMedium.dscodegpt
      # Blackboxapp.blackbox
      # Alibaba-Cloud.tongyi-lingma

      # VIM
      asvetliakov.vscode-neovim
      # vscodevim.vim

      # Snippets
      visualstudioexptteam.intellicode-api-usage-examples
      visualstudioexptteam.vscodeintellicode
      vscode-snippet.snippet
      zjffun.snippetsmanager
      inu1255.easy-snippet
      antonreshetov.masscode-assistant

      # Docs/Notes
      deerawan.vscode-dash
      gruntfuggly.todo-tree
      alefragnani.bookmarks
      alefragnani.project-manager

      # Git
      mhutchie.git-graph
      donjayamanne.githistory
      pomber.git-file-history
      moshfeu.compare-folders
      eamodio.gitlens
      adam-bender.commit-message-editor
      github.vscode-github-actions
      github.vscode-pull-request-github
      github.remotehub

      # Remote
      ms-vscode-remote.remote-containers
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
      ms-vscode-remote.remote-wsl
      ms-vscode-remote.vscode-remote-extensionpack
      ms-vscode.azure-repos
      ms-vscode.remote-explorer
      ms-vscode.remote-repositories
      ms-vscode.remote-server
      kelvin.vscode-sshfs

      # Theme
      unthrottled.doki-theme
      emmanuelbeziat.vscode-great-icons

      # Funny
      # AlexShenVSCode.vscode-osu
      # hoovercj.vscode-power-mode
      # ezshine.rainbow-fart-waifu
      # deepred.daily-anime

      # Others
      davidanson.vscode-markdownlint
      editorconfig.editorconfig
      emilast.logfilehighlighter
      grapecity.gc-excelviewer
      hediet.debug-visualizer
      jock.svg
      ms-vscode.vscode-speech
      mutantdino.resourcemonitor
      quicktype.quicktype
      redhat.vscode-yaml
      ryu1kn.edit-with-shell
      shardulm94.trailing-spaces
      shd101wyy.markdown-preview-enhanced
      sleistner.vscode-fileutils
      tamasfe.even-better-toml
      usernamehw.errorlens
      yutengjing.open-in-external-app
      yzhang.markdown-all-in-one
    ];
    mutableExtensionsDir = true;
    userSettings = { };
    userTasks = { };
    keybindings = [ ];
    globalSnippets = { };
    languageSnippets = { };
    haskell.enable = false;
    haskell.hie.enable = false;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
