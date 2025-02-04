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
      # nerdfonts.DroidSansMono 
      # nerd-fonts.Lekton
      # nerd-fonts.Monofur
      # nerd-fonts.DaddyTimeMono
      # nerd-fonts."3270"
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
        iosevka-term
        hasklug
        geist-mono
      ]);
};
}
