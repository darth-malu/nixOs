{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    # enableGhostscriptFonts = true; # TODO see if needed
    packages =
      with pkgs;
      [
        jetbrains-mono
        font-awesome
        texlivePackages.nunito
        texlivePackages.plex
        inter
        quicksand
        iosevka-comfy.comfy
        ibm-plex
        inconsolata
        lato # unneeded?
        # cascadia-code
        # fira-code
        # fira-math
        office-code-pro # try
      ]
      ++ [
        # emacs fonts
        emacs-all-the-icons-fonts
        noto-fonts-color-emoji
        noto-fonts
      ]
      ++ (with pkgs.nerd-fonts; [
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
        ubuntu-mono
        symbols-only
        # shure-tech-mono
        # agave
        # caskaydia-cove
        # lilex # kinda nice actually
        # hasklug # kinda looks like sauce code pro
        # tinos # similar to times new roman
      ]);
  };
}
