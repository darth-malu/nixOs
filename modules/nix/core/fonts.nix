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
        texlivePackages.nunito # kinda like quicksand
        inter
        quicksand
        iosevka-comfy.comfy
        # lato # unneeded?
        # cascadia-code
        # fira-code
        # fira-math
      ]
      ++ [
        # emacs fonts
        emacs-all-the-icons-fonts
        noto-fonts-color-emoji
        noto-fonts
      ]
      ++ (with pkgs.nerd-fonts; [
        space-mono
        menlo-lg
        zed-mono
        daddy-time-mono
        jetbrains-mono
        victor-mono
        monaspace
        martian-mono
        sauce-code-pro
        lekton
        geist-mono
        monofur # nice stylistic
        mononoki # kinda nice style
        fantasque-sans-mono
        ubuntu-mono
        symbols-only # for wezterm/terminal in general glyphs, also emacs
        # shure-tech-mono
        # agave
        # caskaydia-cove
        # lilex # kinda nice actually
        # hasklug # kinda looks like sauce code pro
        # tinos # similar to times new roman
      ]);
  };
}
