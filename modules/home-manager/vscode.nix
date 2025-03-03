{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.vscode = {
    # TODO: FIXME
    enable = false;
    package = pkgs.vscodium;
    extensions =
      let
        pkgs-vscode-extensions = with pkgs.vscode-extensions; [ ];
        # TODO: FIXME
        vscode-marketplace-release-extensions = with inputs.nix-vscode-extensions.extensions.${globals.system}.vscode-marketplace-release; [ ];
        vscode-marketplace-extensions = with inputs.nix-vscode-extensions.extensions.${globals.system}.vscode-marketplace; [
          # assembly
          dan-c-underwood.arm
          platformio.platformio-ide
          cl.eide
          # "13xforever".language-x86-64-assembly

          # c/c++
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

          # rust
          fill-labs.dependi
          rust-lang.rust-analyzer
          vadimcn.vscode-lldb

          # go
          golang.go
          xiaoxin-technology.goctl

          # web - js/ts/css/html
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
          abhipatel.jquery-snippets
          dsznajder.es7-react-js-snippets
          ecmel.vscode-html-css
          esbenp.prettier-vscode
          firefox-devtools.vscode-firefox-debug
          hollowtree.vue-snippets
          mariusschulz.yarn-lock-syntax
          ms-vscode.live-server
          ritwickdey.liveserver
          msjsdiag.vscode-react-native
          octref.vetur
          otovo-oss.htmx-tags
          pcbowers.alpine-intellisense
          pranaygp.vscode-css-peek
          rvest.vs-code-prettier-eslint
          humao.rest-client
          sdras.vue-vscode-snippets
          orta.vscode-jest
          vue.volar
          # wallabyjs.quokka-vscode
          xabikos.javascriptsnippets
          zignd.html-css-class-completion
          yoavbls.pretty-ts-errors
          youngjuning.yarn-lock-preview
          zxh404.vscode-proto3

          # jvm - java/kotlin/scala/clojure
          betterthantomorrow.calva-spritz
          betterthantomorrow.calva
          vscjava.vscode-java-pack
          fwcd.kotlin
          scalameta.metals
          scala-lang.scala
          sonarsource.sonarlint-vscode
          vmware.vscode-boot-dev-pack

          # lua
          sumneko.lua
          actboy168.lua-debug

          # matlab
          affenwiesel.matlab-formatter
          apommel.matlab-interactive-terminal
          bat67.matlab-extension-pack

          # lisp
          mattn.lisp

          # nix
          pinage404.nix-extension-pack

          # .net - c#/f#/powershell
          ms-dotnettools.vscodeintellicode-csharp
          ionide.ionide-fsharp
          ms-vscode.powershell
          ms-dotnettools.dotnet-interactive-vscode

          # php
          zobo.php-intellisense
          xdebug.php-debug
          xdebug.php-pack

          # python
          ms-python.python
          ms-python.vscode-pylance
          ms-python.debugpy
          njpwerner.autodocstring
          rodolphebarbanneau.python-docstring-highlighter
          seanwu.vscode-qt-for-python
          ericsia.pythonsnippets3
          # "076923".python-image-preview
          batisteo.vscode-django
          junstyle.vscode-django-support
          samuelcolvin.jinjahtml
          battlebas.kivy-vscode
          ms-toolsai.jupyter
          ms-python.mypy-type-checker
          charliermarsh.ruff
          ms-python.vscode-python-envs

          # devops
          redhat.ansible
          mrmlnc.vscode-apache
          ahmadalli.vscode-nginx-conf
          raynigon.nginx-formatter
          eiminsasete.apacheconf-snippets
          thqby.vscode-autohotkey2-lsp
          rogalmic.bash-debug
          mads-hartmann.bash-ide-vscode
          jeff-hykin.better-dockerfile-syntax
          srl-labs.vscode-containerlab
          jeff-hykin.better-shellscript-syntax
          samuelcolvin.jinjahtml
          mindaro.mindaro
          matthewpi.caddyfile-support
          formulahendry.code-runner
          ms-azuretools.vscode-docker
          p1c2u.docker-compose
          exiasr.hadolint
          maarti.jenkins-doc
          # ivory-lab.jenkinsfile-support
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
          remisa.shellman
          hangxingliu.vscode-systemd-support
          bbenoist.vagrant
          # marcostazi.vs-code-vagrantfile

          # ==== common ====

          # ai
          codeium.codeium
          # continue.continue
          # dreamlight.aline
          # coolcline.coolcline
          # rooveterinaryinc.roo-cline
          # saoudrizwan.claude-dev
          # github.copilot
          # github.copilot-chat
          # codium.codium
          # aminer.codegeex
          # danielsanmedium.dscodegpt
          # blackboxapp.blackbox
          # alibaba-cloud.tongyi-lingma

          # vim
          asvetliakov.vscode-neovim
          # vscodevim.vim

          # snippets
          visualstudioexptteam.intellicode-api-usage-examples
          visualstudioexptteam.vscodeintellicode
          vscode-snippet.snippet
          zjffun.snippetsmanager
          inu1255.easy-snippet
          antonreshetov.masscode-assistant

          # docs/notes
          deerawan.vscode-dash
          gruntfuggly.todo-tree
          alefragnani.bookmarks
          alefragnani.project-manager

          # git
          mhutchie.git-graph
          donjayamanne.githistory
          pomber.git-file-history
          moshfeu.compare-folders
          eamodio.gitlens
          adam-bender.commit-message-editor
          github.vscode-github-actions
          github.vscode-pull-request-github
          github.remotehub

          # remote
          ms-vscode-remote.remote-containers
          ms-vscode-remote.remote-ssh
          ms-vscode-remote.remote-ssh-edit
          # ms-vscode-remote.remote-wsl
          ms-vscode-remote.vscode-remote-extensionpack
          ms-vscode.azure-repos
          ms-vscode.remote-explorer
          ms-vscode.remote-repositories
          ms-vscode.remote-server
          kelvin.vscode-sshfs

          # theme
          unthrottled.doki-theme
          emmanuelbeziat.vscode-great-icons

          # funny
          # alexshenvscode.vscode-osu
          # hoovercj.vscode-power-mode
          # ezshine.rainbow-fart-waifu
          # deepred.daily-anime

          # others
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
          rszyma.vscode-kanata
        ];
        open-vsx-release-extensions = with inputs.nix-vscode-extensions.extensions.${globals.system}.open-vsx-release; [ ];
        open-vsx-extensions = with inputs.nix-vscode-extensions.extensions.${globals.system}.open-vsx; [ ];
      in
        pkgs-vscode-extensions
        ++ vscode-marketplace-release-extensions
        ++ vscode-marketplace-extensions
        ++ open-vsx-release-extensions
        ++ open-vsx-extensions
      ;
    mutableExtensionsDir = true;
    userSettings = { };
    userTasks = { };
    keybindings = [ ];
    globalSnippets = { };
    languageSnippets = { };
    haskell.enable = false;
    haskell.hie.enable = false;
  };
}
