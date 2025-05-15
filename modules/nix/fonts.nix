{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    enableGhostscriptFonts = true;
    packages =
      with pkgs;
      [
        #terminus_font noto-fonts fira-code noto-fonts-cjk-sans
        fira-code
        fira-math
        monaspace
        jetbrains-mono
        font-awesome
        texlivePackages.nunito
        inter
        quicksand
        lato # unneeded?
        cascadia-code
        iosevka-comfy.comfy
      ]
      ++ [
        # fonts
        emacs-all-the-icons-fonts
      ]
      ++ (with pkgs.nerd-fonts; [
        # fira-mono
        fantasque-sans-mono
        zed-mono
        daddy-time-mono
        shure-tech-mono
        jetbrains-mono
        # fira-code
        victor-mono
        ubuntu-mono
        space-mono
        mononoki
        # monaspace
        martian-mono
        sauce-code-pro
        # hasklug # kinda looks like sauce code pro
        tinos # similar to times new roman
        # iosevka-term
        # iosevka
        # DroidSansMono #FIXME: broken
        # "3270" #FIXME: broken
        lekton
        lilex # kinda nice actually
        geist-mono
        agave
        caskaydia-cove
        monofur
        symbols-only # for wezterm/terminal in general glyphs, also emacs
      ]);
  };
}
