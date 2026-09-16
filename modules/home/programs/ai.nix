{ pkgs, ... }:
{
  programs = {
    opencode = {
      enable = true;
      package = pkgs.opencode;
      extraPackages = [ pkgs.uv ];
      settings = {
        autoshare = false;
        autoupdate = true;
        # model = "anthropic/claude-sonnet-4-20250514";
        # "attention" = {
        #   "enabled" = true;
        #   "notifications" = true;
        #   "sound" = true;
        #   "volume" = 0.4;
        # };
        # shell = "bash";
      };
      tui = {
        theme = "one-dark";
      };
    };

    antigravity = {
      enable = true;
      # defaultModel = "gemini-2.5-flash";
      mutableExtensionsDir = true;
      # context
      # settings = {
      #   theme = "Default";
      #   vimMode = true;
      #   preferredEditor = "vim";
      #   autoAccept = true;
      # };
    };
  };
}
