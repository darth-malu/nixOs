{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true; # install basic fonts for unicode coverage
    # enableGhostscriptFonts = true; #  URW fonts and the “Base-14” Postscript fonts) to the list of system fonts, making them available to X11 applications.
    packages =
      with pkgs;
      [
        jetbrains-mono
        # font-awesome
        texlivePackages.nunito
        texlivePackages.plex
        inter
        quicksand
        iosevka-comfy.comfy
        ibm-plex
        # inconsolata
        lato # unneeded?
        atkinson-hyperlegible-mono
        # cascadia-code
        # fira-code
        # fira-math
        # office-code-pro # try
        symbola # emacs fallback
      ]
      ++ [
        # emacs fonts
        emacs-all-the-icons-fonts
        noto-fonts-color-emoji
        noto-fonts
      ]
      ++ (with pkgs.nerd-fonts; [
        proggy-clean-tt
        envy-code-r
        space-mono
        meslo-lg # try
        zed-mono
        daddy-time-mono
        jetbrains-mono
        victor-mono
        monaspace
        martian-mono
        sauce-code-pro
        lekton
        geist-mono
        monofur
        mononoki
        fantasque-sans-mono
        # ubuntu-mono
        symbols-only
        # shure-tech-mono
        # agave
        caskaydia-cove
        lilex # kinda nice actually
        # hasklug # kinda looks like sauce code pro
        # tinos # similar to times new roman
      ]);
  };
}
