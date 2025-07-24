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
      # clang-format # FIXME
      # mbsync # for mu4e FIXME
      djvu
      # mu4e
      # jupyter
      # prettier
      # org-tidy
      # ebuku
      # lsp-pyright
      # emacs-all-the-icons-fonts
    ];

  programs.mbsync = {
    enable = true;
    extraConfig = ''
      IMAPAccount gmail
      Host imap.gmail.com
      User justinmalu@gmail.com
      PassCmd "cat ~/Documents/gog.txt"
      SSLType IMAPS
      CertificateFile /etc/ssl/certs/ca-certificates.crt

      IMAPStore gmail-remote
      Account gmail

      MaildirStore gmail-local
      Subfolders Verbatim
      Path ~/Mail/
      Inbox ~/Mail/Inbox

      # With mbsync 1.4.0 and later: Use 'Far' instead of 'Master', and
      # 'Near' instead of 'Slave'.
      Channel gmail
      Far :gmail-remote:
      Near :gmail-local:
      Patterns * ![Gmail]* "[Gmail]/Sent Mail" "[Gmail]/Starred" "[Gmail]/All Mail" "[Gmail]/Trash"
      Create Both
      SyncState *
    '';
    groups = {
    };
  };

  home.packages = with pkgs; [
    # prettier
    prettierd # prettier as a daemon, for improved speed
    gnumake # for compiling vterm
    xclip
    tex
    offlineimap # for mu4e
    libtool
    shellcheck

    # c#
    csharpier # c# formatter
    mono
    csharprepl

    mu # mu4e
    # micromamba
    # conda
    # qtcreator
    (pkgs.python3.withPackages (
      python-pkgs: with python-pkgs; [
        # jupyter-core
        jupyter-console
        # jupyterlab-server
        pyside6
        # pytube
        pytubefix
        pandas
        # numpy
        seaborn
        matplotlib
        tkinter

        requests
        ttkbootstrap # MOVED to Qt😄
        # pandasql

        #emacs
        weasyprint
        pytest
        pyflakes
        isort
        nose2pytest
        grip
      ]
    ))
    cmake # vterm
    # gnumake
    ## Module dependencies
    # :email mu4e
    # mu
    # isync
    # Because emacs expects the dictionaries to be on the same directory as aspell, they won't be picked up. To fix it install the aspellWithDicts package, specifying the dictionaries you want to use:
    (aspellWithDicts (
      ds: with ds; [
        en
        en-computers
        en-science
      ]
    ))
    hunspell
    # clang-tools
    wordnet # +dictionary
    sqlite # org-roam
    # :tools editorconfig
    editorconfig-core-c # per-project style config
    # :lang nix
    age
    zstd # for undo-fu-session/undo-tree compression
    binutils # native-comp needs 'as', provided by this

    nil
    nixd # for zed as well
    pyright
    bash-language-server # I never really have bash files to edit lol
    omnisharp-roslyn # c#
    jdt-language-server
    # lua-language-server
    basedpyright
    black
    nixfmt-rfc-style # official - needed to use formatting with :lang nix

    emacs-lsp-booster

    # org stuff
    scrot # for org-screenshot-take

    # export dep
    wkhtmltopdf
    groff # ms-pdf export
    ghostscript

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

    # lsp
    nodejs_24 # consider npm for auto install of servers in lsp-mode
  ];
}
