{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    # package = pkgs.emacs-gtk; # emacs, emacs-gkt
    package = pkgs.emacs; # emacs, emacs-gkt
    extraConfig = ''
      (setq standard-indent 2)
    '';
    extraPackages =
      epkgs: with epkgs; [
        # nix-env -f '<nixpkgs>' -qaP -A emacsPackages
        treesit-grammars.with-all-grammars
        magit
        vterm
        mu4e
        prettier
        org-tidy

        npm

        # python
        # python-isort
        # py-isort this and isortify ... break emacs convention

        # flycheck-pyflakes
        # flymake-python-pyflakes
        # pipenv # does nott work
        # pytest
        # python-black
        # eww # FIXME: why doesnt this work
        # grip-mode # markdown grip mode

        # shfmt # sh format
        #
        # emacs-all-the-icons-fonts
      ];
    # overrides = self: super: rec {
    #   haskell-mode = self.melpaPackages.haskell-mode;
    #     # ...
    #   };
  };

  services.emacs = {
    enable = true; # emacs daemon
    startWithUserSession = true; # whether to launch Emacs servicee with the systemd session
    #package = emacs;
    defaultEditor = true;
    # socketActivation.enable = true; # Whether to enable systemd socket activation for the Emacs service. # NOTE: works as needed without
    client = {
      enable = true; # false::, generation of Emacs client desktop file.
      arguments = [
        "-c" # open in emacs frame / GUI frame
        # "-a 'emacs'"
      ];
    };
    # package =;
    # extraOptions = ''
    # '';
  };
}
