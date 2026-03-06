{
  programs.bun = {
    enable = true;
    enableGitIntegration = true;
    settings = {
      # https://bun.sh/docs/runtime/bunfig
      telemetry = false;
      jsx = "react";
      # tsx = "react";
      # smol = true; # Reduce memory usage at the cost of performance
    };
  };
}
