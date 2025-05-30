{ pkgs, ... }:
{
  imports = [
    ./pkgs.nix
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
          treesit-grammars.with-all-grammars
          magit
          vterm
          mu4e
          prettier
          org-tidy
          ebuku
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
      # startWithUserSession = true; # whether to launch Emacs servicee with the systemd session. boolean or "graphical" (default.target::) #TODO test without
      defaultEditor = true;
      socketActivation.enable = false; # Whether to enable systemd socket activation for the Emacs service. # NOTE: very slow to launch
      client = {
        enable = false; # false::, generation of Emacs client desktop file.
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
