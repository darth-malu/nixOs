{
  # config= lib.mkIf (config.specialisation != {}) {
  # config= lib.mkIf config.hyprland.enable {
  environment = {
    # sessionVariables = {#PAM
    # };
    # profileRelativeSessionVariables = {#PAM
    # };
    variables = {
      #global - on shell init
      #ROC_ENABLE_PRE_VEGA = "1"; #enable opencl polaris
      NIXOS_OZONE_WL = "1";
      # For packages that dont yet support the above
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      SUDO_PROMPT = "$(tput setaf 199 bold) $(tput sgr0) "; # 219
    };
  };
  # };
}
