{
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
      # SUDO_PROMPT = "$(tput sgr0)$(tput setaf 199; tput bold) $(tput sgr0) "; # 219
      SUDO_PROMPT = "$(tput sgr0)$(tput setaf 199) $(tput sgr0) "; # 219
    };
  };
  # };
}
