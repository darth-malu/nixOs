{pkgs, self, ...}:
{
  # nixpkgs.overlays = [
    # (import (builtins.fetchTarball { # without flakes
    #   url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
    #   sha256 = "1alq3q40x2b43d1lx5cx715r73966q676b8cr84i4nb9pg372wqq";})
    # )
    # (import self.inputs.emacs-overlay) # with flakes
  # ];

  environment.systemPackages = [
    # emacs itself
    # (pkgs.emacsWithPackagesFromUsePackage {
    #   package = pkgs.emacs-git;  # replace with pkgs.emacsPgtk, or another version if desired.
    #   config = "$HOME/.doom.d/config.el";
      # config = path/to/your/config.org; # Org-Babel configs also supported

      # Optionally provide extra packages not in the configuration file.
      # extraEmacsPackages = epkgs: with epkgs;[
      #   vterm
      #   # epkgs.use-package;
      # ];

      # Optionally override derivations.
      # override = epkgs: epkgs // {
      # somePackage = epkgs.melpaPackages.somePackage.overrideAttrs(old: {
      # Apply fixes here
      # });
      # };
    # })
  ];

  programs.emacs = {
    enable = false ; #NOTE using hModule
    extraConfig = '''';
    extraPackages = [];
    # overrides =
    #   self: super: rec {
    #     haskell-mode = self.melpaPackages.haskell-mode;
    #     # ...
    # }
    # ;
  };

  services.emacs = {
    enable = true; # auto-enables install option by default
    install = true; # enables use of emacsclient to connect to daemon otherwise do: systemctl --user start emacs
  };
}
