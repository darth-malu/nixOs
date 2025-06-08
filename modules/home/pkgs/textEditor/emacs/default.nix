{ pkgs, ... }:
{
  imports = [
    ./emacsPkgs.nix
  ];

  config = {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs-gtk; # emacs, emacs-gkt
      extraConfig = ''
        (setq standard-indent 2)
      '';
      extraPackages =
        epkgs: with epkgs; [
          treesit-grammars.with-all-grammars # for bash-ts-mode
          # magit
          vterm
          mu4e
          # prettier
          # org-tidy
          # ebuku
          # lsp-pyright
          # emacs-all-the-icons-fonts
        ];
      # overrides = self: super: rec {
      #   haskell-mode = self.melpaPackages.haskell-mode;
      #     # ...
      #   };
    };

    services.emacs = {
      enable = true; # emacs daemon
      startWithUserSession = true; # whether to launch Emacs servicee with the systemd session. boolean or "graphical" (default.target::) #TODO test without
      defaultEditor = true;
      socketActivation.enable = true; # Whether to enable systemd socket activation for the Emacs service. # NOTE: very slow to launch
      client = {
        enable = true; # false::, generation of Emacs client desktop file. FIXME not work?
        arguments = [
          "-c" # open in emacs frame / GUI frame
          # "-a 'emacs'"
        ];
      };
      # package =;
      # extraOptions = ''
      # '';
    };
  };
}
