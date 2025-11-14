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
      # jupyter
      # prettier
      # org-tidy
      # ebuku
      # lsp-pyright
      # emacs-all-the-icons-fonts
    ];

  home.packages = with pkgs; [
    # debug init launcher
    # (mkLauncherEntry "Emacs (Debug Mode)" {
    #   description = "Start Emacs in debug mode";
    #   icon = "emacs";
    #   exec = "${emacs}/bin/emacs --debug-init";
    # })

    direnv
    emacs-lsp-booster
    # prettier
    prettierd # prettier as a daemon, for improved speed # TODO test workings

    # xclip #TODO see if need with wl-clip
    libtool
    shellcheck

    #:lang latex, org (latex previews)
    tex
    # Javascript
    # deno

    # :emacs dired +dirvish
    ffmpegthumbnailer
    mediainfo
    vips

    (pkgs.python3.withPackages (
      python-pkgs: with python-pkgs; [
        jupyter-console # jupyter-core jupyterlab-server
        pyside6
        pytubefix
        pandas
        moviepy
        # numpy
        # seaborn
        # matplotlib

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

      ]
    ))

    # C
    # clang # cc lsp & java? (maybe since derived) # FIXME...clash with binutils and gcc
    # clang-tools # collection of helper programs ontop of clang eg. clangd
    # libclang # java #clang-format (clangd)
    ccls

    # Doom Dependencies
    gnumake # for compiling vterm
    gnutls # to TLS connectivity
    binutils # native-comp needs 'as'...NOTE also has ld needed for clang?

    # C#
    # csharpier # c# formatter
    # csharprepl # coolest repl

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
