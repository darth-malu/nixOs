{
  imports = [
    ./dunst.nix
    # ./eww
    ./rofi
    ./waybar
    ./scripts
    ./hypr-ecos
    # inputs.hyprshell.homeModules.hyprshell
  ];

  # programs.hyprshell = {
  #   enable = false;
  #   systemd.args = "-v";
  #   settings = {
  #     launcher = {
  #       max_items = 6;
  #       plugins.websearch = {
  #         enable = true;
  #         engines = [
  #           {
  #             name = "DuckDuckGo";
  #             url = "https://duckduckgo.com/?q=%s";
  #             key = "d";
  #           }
  #         ];
  #       };
  #     };
  #     # window.switcher.enable = false;
  #   };
  # };
}
