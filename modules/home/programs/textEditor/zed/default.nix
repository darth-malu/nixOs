{pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;

    # package = pkgs.zed-editor;
    extraPackages = [
      pkgs.nixd
      # pkgs.nil
    ];

    userSettings = {

    };

  }; # end of programs.zed
}
