{
  environment = {
    variables = { # global during shell init
      # ROC_ENABLE_PRE_VEGA = "1"; #enable opencl polaris
      # UWSM_WAIT_VARNAMES="$UWSM_WAIT_VARNAMES FINALIZED";
      # UWSM_WAIT_VARNAMES_SETTLETIME="0.4"; # default: 0.2
      # UWSM_USE_SESSION_SLICE="true"; # launch compositor in session.slice instead of default app.slice
      # NIXOS_OZONE_WL = "1";
      # For packages that dont yet support the above
      # ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };

    sessionVariables = {
      # UWSM_WAIT_VARNAMES="$UWSM_WAIT_VARNAMES";
      # UWSM_WAIT_VARNAMES="WAYLAND_DISPLAY";
      # UWSM_FINALIZE_VARNAMES="";
      # UWSM_WAIT_VARNAMES_SETTLETIME="0.4"; # default: 0.2
      # UWSM_USE_SESSION_SLICE="true"; # launch compositor in session.slice instead of default app.slice
    };
  };
}
