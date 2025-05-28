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
  home.packages = with pkgs; [
    # NOTE: EMACS
    xclip
    tex
    libtool
    shellcheck
    # cmake
    # gnumake
    ## Module dependencies
    # :email mu4e
    # mu
    # isync
    # :checkers spell
    # Because emacs expects the dictionaries to be on the same directory as aspell, they won't be picked up. To fix it install the aspellWithDicts package, specifying the dictionaries you want to use:
    # (aspellWithDicts (
    #   ds: with ds; [
    #     en
    #     en-computers
    #     en-science
    #   ]
    # ))
    hunspell
    # clang-tools
    wordnet # :tools +dictionary dep
    # :tools lookup & :lang org +roam
    sqlite
    # :tools editorconfig
    editorconfig-core-c # per-project style config
    # :lang nix
    age
    zstd # for undo-fu-session/undo-tree compression
    binutils # native-comp needs 'as', provided by this

    # LSP stuff
    nil
    pyright
    # bash-language-server
    # basedpyright
    black
    # nixd
    nixfmt-rfc-style # official - needed to use formatting with :lang nix

    emacs-lsp-booster # TODO: test if this works

    # org stuff
    scrot # for org-screenshot-take

    # export dep
    wkhtmltopdf

    nodePackages.js-beautify # js/css/html format
    stylelint # css linter

    graphviz # for org-roam visualization

    imagemagick # for image-dired, has convert:
    unzip # for tldr

    # python
    pipenv
    black
    shfmt
    libxml2
    pyenv

    # web
    html-tidy

    (pkgs.python3.withPackages (
      python-pkgs: with python-pkgs; [
        pandas
        # numpy
        seaborn
        matplotlib
        tkinter
        # pip
        requests
        ttkbootstrap
        # pandasql
        #emacs
        weasyprint
        pytest
        pyflakes
        isort
        nose2pytest
        grip
        conda
      ]
    ))
    # lsp
    nodejs_24 # consider npm for auto install of servers in lsp-mode
  ];
}
