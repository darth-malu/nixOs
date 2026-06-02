{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true; # install basic fonts for unicode coverage
    # enableGhostscriptFonts = true; #  URW fonts and the “Base-14” Postscript fonts) to the list of system fonts, making them available to X11 applications.
    packages =
      with pkgs;
      [
        jetbrains-mono
        texlivePackages.nunito
        inter
        quicksand
        iosevka-comfy.comfy
        ibm-plex
        lato # unneeded?
        atkinson-hyperlegible-mono
      ]
      ++ [
        # emacs fonts
        symbola # emacs fallback
        emacs-all-the-icons-fonts
        noto-fonts-color-emoji
        noto-fonts
      ]
      ++ (with pkgs.nerd-fonts; [
        zed-mono
        daddy-time-mono
        jetbrains-mono
        victor-mono
        monaspace
        monofur
        mononoki
        fantasque-sans-mono
        symbols-only
      ]);
  };
}
