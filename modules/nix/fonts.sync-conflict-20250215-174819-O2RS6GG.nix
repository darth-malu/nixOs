{ pkgs,... }:

{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      #terminus_font noto-fonts fira-code noto-fonts-cjk-sans
      jetbrains-mono
      font-awesome
      texlivePackages.nunito
      inter
      quicksand
      lato 
      cascadia-code
      # whatsapp-emoji-font # long build time strange
      ]++
        (with pkgs.nerd-fonts; [
        fantasque-sans-mono
        zed-mono
        daddy-time-mono
        shure-tech-mono
        jetbrains-mono
        fira-code
        victor-mono
        ubuntu-mono
        space-mono
        mononoki
        monaspace
        martian-mono
        sauce-code-pro
        tinos # similar to times new
        # iosevka-term
        iosevka
        # DroidSansMono 
        # "3270"
        lekton
        lilex
        hasklug
        geist-mono
        agave
        caskaydia-cove
        # symbols-only # for wezterm/terminal in general glyphs
      ]);
};
}
