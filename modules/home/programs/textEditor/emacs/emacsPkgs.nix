{ pkgs, inputs, ... }:
let
  texx = (
    pkgs.texlive.combine {
      inherit (pkgs.texlive)
        scheme-basic
        scheme-medium
        dvisvgm
        dvipng # for preview and export as html
        wrapfig
        amsmath
        ulem
        hyperref
        capt-of
        ;
      #(setex-compiler "lualatex")
      #(setq org-preview-latex-default-process 'dvisvgm)
    }
  );
in
{
  programs = {
    gcc = {
      enable = true;
      colors = {
        error = "01;31";
      };
    };
  };

  programs.emacs.extraPackages =
    epkgs: with epkgs; [
      treesit-grammars.with-all-grammars # for bash-ts-mode
      vterm
      djvu
      mu4e
    ];

  home.packages = with pkgs; [
    emacs-lsp-booster
    inputs.nix-qml.packages.${pkgs.stdenv.hostPlatform.system}.tree-sitter-qmljs
    inputs.nix-qml.packages.${pkgs.stdenv.hostPlatform.system}.qml-ts-mode
    # prettier
    # prettierd # prettier as a daemon, for improved speed # TODO test workings

    libtool
    shellcheck

    # Latex
    auctex
    texlab
    texx # :lang latex, org (latex previews)

    # :emacs dired +dirvish
    ffmpegthumbnailer
    mediainfo
    vips

    # python3 or or specific number
    (pkgs.python3.withPackages (
      python-pkgs: with python-pkgs; [
        # gnureadline     # NOTE python-shell-interpreter not supporting readline warning fix
        pyside6
        # ffmpeg-python

        # Machine Learning
        scikit-learn
        jupyterlab
        jupyter-console # jupyter-core jupyterlab-server
        nbformat
        jupyterlab-lsp
        # jupyterlab-widgets
        nbconvert
        numpy
        seaborn
        matplotlib
        # pandasql
        pycryptodome
        pandas

        # ELPy
        # autopep8
        # jedi
        # yapf
        # flake8

        # Installers
        pytubefix
        nuitka
        pyinstaller

        requests

        # Web Scraping
        beautifulsoup4

        #emacs
        weasyprint # needed for some exports to work
        pytest
        pyflakes
        isort # sort imports block
        grip

        # Testing
        # pytest-mock # yyoutubr pytest
        # pytest-mockservers

      ]
    ))

    # python
    # pipenv pipenv support
    basedpyright
    # pyright
    black
    shfmt
    libxml2
    # pyenv
    # ELPY

    # NODE / Javascript
    nodejs_25 # consider npm for auto install of servers in lsp-mode
    # deno

    # C
    # clang # cc lsp & java? (maybe since derived) # FIXME...clash with binutils and gcc
    clang-tools # collection of helper programs ontop of clang eg. clangd - fixes issue with clang-format
    ccls

    # Doom Dependencies
    gnumake # for compiling vterm
    cmake # vterm
    # gnutls # to TLS connectivity
    binutils # native-comp needs 'as'...NOTE also has ld needed for clang?

    # C#
    csharpier # c# formatter
    csharprepl # coolest repl

    ## Dictionary
    (aspellWithDicts (
      # Because emacs expects the dictionaries to be on the same directory as aspell, they won't be picked up. To fix it install the aspellWithDicts package, specifying the dictionaries you want to use:
      ds: with ds; [
        en
        en-computers
        en-science
      ]
    ))
    # hunspell
    languagetool # lang:grammar
    wordnet # +dictionary
    sqlite # org-roam
    # editorconfig-core-c # per-project style config# TODO use

    # :lang nix
    nil
    # nixd # for zed as well
    nixfmt # nixfmt-rfc-style # official - needed to use formatting with :lang nix

    age
    zstd # undo-fu-session/undo-tree compression

    bash-language-server

    # omnisharp-roslyn # c#
    # jdt-language-server

    # lua-language-server

    # WEB
    nodePackages.js-beautify # js/css/html format
    stylelint # css linter
    html-tidy

    # org stuff
    scrot # org-screenshot-take
    # export dep
    wkhtmltopdf
    groff # ms-pdf export
    ghostscript
    graphviz # org-roam visualization

    # MISC
    imagemagick # image-dired, has convert:
    unzip # tldr

  ];
}
