{ pkgs,... }:

{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      #terminus_font noto-fonts fira-code noto-fonts-cjk-sans
      jetbrains-mono font-awesome texlivePackages.nunito inter quicksand lato cascadia-code
      (nerdfonts.override {fonts = [
        "JetBrainsMono"
        "VictorMono"
        "Hasklig"
        "Lekton"
        "Monofur"
        "IosevkaTerm"
        "SpaceMono"
        "Ubuntu"
        "ZedMono"
        "DaddyTimeMono"
        "3270"
      ];})
  ];
};
}
