{ pkgs, ... }:
let
  tex = (
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
      #(setq org-latex-compiler "lualatex")
      #(setq org-preview-latex-default-process 'dvisvgm)
    }
  );
in
{
  programs.emacs.extraPackages =
    epkgs: with epkgs; [
      treesit-grammars.with-all-grammars # for bash-ts-mode
      vterm
      djvu
      mu4e
      # jupyter
      # prettier
      # org-tidy
      # ebuku
      # lsp-pyright
      # emacs-all-the-icons-fonts
    ];

  home.packages = with pkgs; [
    # General lsp stuff
    emacs-lsp-booster
    # prettier
    prettierd # prettier as a daemon, for improved speed # TODO test workings

    # EMAIL
    mu

    xclip
    tex
    libtool
    shellcheck
    # libclang # java #TODO see need

    # clang # cc lsp & java? (maybe since derived) # FIXME...clash with other clang

    # Javascript
    # deno

    # C#
    # csharpier # c# formatter
    # csharprepl # coolest repl

    (pkgs.python3.withPackages (
      python-pkgs: with python-pkgs; [
        jupyter-console # jupyter-core jupyterlab-server
        pyside6
        # pytube
        pytubefix
        pandas
        # moviepy
        # numpy
        # seaborn
        # matplotlib
        # tkinter

        # Installers
        nuitka
        pyinstaller

        requests
        ttkbootstrap # MOVED to Qt😄
        # pandasql

        #emacs
        weasyprint
        pytest
        pyflakes
        isort
        grip

        # C
        # clang-tools #TODO see need
      ]
    ))

    cmake # vterm #FIXME make still not found
    # gnumake # for compiling vterm

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
    wordnet # +dictionary
    sqlite # org-roam
    # editorconfig-core-c # per-project style config# TODO use

    # :lang nix
    nil
    nixd # for zed as well
    nixfmt-rfc-style # official - needed to use formatting with :lang nix

    age
    zstd # undo-fu-session/undo-tree compression
    binutils # native-comp needs 'as'

    #bash
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

    # python
    pipenv
    basedpyright
    pyright
    black
    shfmt
    libxml2
    pyenv

    # lsp
    nodejs_24 # consider npm for auto install of servers in lsp-mode
  ];
}
