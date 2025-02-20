{pkgs,...}:
{
  programs.emacs = {
    enable = true;
    defaultEditor = false;
    package = pkgs.emacs-gkt; # emacs, emacs-gkt
    extraConfig = ''
      (setq standard-indent 2)
    '';
  };
}
