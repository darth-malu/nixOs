{pkgs,...}:

let
  emacs = with pkgs; ((emacsPackagesFor  emacsNativeComp).emacsWithPackages (epkgs: with epkgs; [
    treesit-grammars.with-all-grammars
    vterm
    mu4e
  ]));
in
{
  programs.emacs = {
    enable = true;
    # package = pkgs.emacs-gtk; # emacs, emacs-gkt
    package = pkgs.emacs-gtk; # emacs, emacs-gkt
    extraConfig = ''
      (setq standard-indent 2)
    '';
    extraPackages = epkgs: with epkgs; [ # nix-env -f '<nixpkgs>' -qaP -A emacsPackages
      treesit-grammars.with-all-grammars
      magit
      vterm
      mu4e
      # eww # FIXME: why doesnt this work
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
    # defaultEditor = true;
    socketActivation.enable = true; # Whether to enable systemd socket activation for the Emacs service.
    client = {
      enable = true; # false::, generation of Emacs client desktop file.
      arguments = [
        "-c" # open in emacs frame
        # "-a 'emacs'"
      ];
    };
    # package =;
    # extraOptions = ''
    # '';
  };
}
