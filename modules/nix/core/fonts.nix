{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true; # install basic fonts for unicode coverage
    # enableGhostscriptFonts = true;
    fontconfig.defaultFonts = {
      serif = [ "IBM Plex Serif" ];
      sansSerif = [
        "quicksand"
        "Inter"
        "nunito"
        "lato"
        "IBM Plex Sans"
      ]; # DejaVu Sans::
      # emoji = ["Noto Color Emoji"];
      monospace = [
        "JetBrains Mono"
        "VictorMono Nerd Font"
      ];
    };
    packages =
      with pkgs;
      [
        # JAPAN
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        ipafont
      ]
      ++ [
        # (texlive.withPackages (ps: [ ps.plex ]))
        # cascadia-code
        # fira-code
        # fira-math
        # font-awesome
        # ibm-plex
        # inconsolata
        # office-code-pro # try
        # texlivePackages.nunito
        # texlivePackages.plex
        atkinson-hyperlegible-mono
        inter
        iosevka-comfy.comfy
        jetbrains-mono
        lato # unneeded?
        nunito
        nunito-sans # TODO: differentiate nunitos
        quicksand
      ]
      ++ [
        # emacs fonts
        emacs-all-the-icons-fonts
        noto-fonts-color-emoji
        noto-fonts
        symbola # emacs fallback
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
