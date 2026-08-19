{
  environment = {
    # sessionVariables = {#PAM
    # };
    # profileRelativeSessionVariables = {#PAM
    # };
    variables = {
      #global - on shell init
      NIXOS_OZONE_WL = "1";
      # For packages that dont yet support the above
      # ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };
  };
}
