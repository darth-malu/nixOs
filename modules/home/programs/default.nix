{
  pkgs,
  inputs,
  lib,
  osConfig,
  config,
  ...
}:

{

  imports = [
    ./yt-dlp
    ./qutebrowser
    ./soundStuff
    ./mpv
    ./git.nix
    ./yazi
    ./shell
    ./hyprland
    ./textEditor
    # ./kdeconnect.nix
    ./pkgs.nix
    ./gpg.nix
    ./nyaa.nix
    ./vim.nix
    # ./kde
  ];

  homeHyprland.enable = lib.mkIf osConfig.programs.hyprland.enable true;

  programs = {
    home-manager.enable = true; # Let Home Manager install and manage itself.
    # eza = {
    #   enable = true;
    # };

    bashmount.enable = true;

    btop.enable = true;

    comodoro.enable = false;

    fastfetch = import ./misc/fastfetch.nix;

    fd = import ./misc/fd.nix;

    freetube = import ./misc/freetube.nix;

    fzf = import ./misc/fzf.nix;

    git-credential-oauth = {
      enable = false;
      extraFlags = [ "-device" ];
    };

    java = {
      enable = true;
      # package = pkgs.jdk23;
    };

    lazygit = import ./misc/lazygit.nix;

    lsd = import ./misc/lsd.nix;

    # nix-index.enable = false;
    # nh.enable = true;

    pandoc.enable = true;

    ripgrep = {
      enable = true;
      arguments = [
        # https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#configuration-file
        "--max-columns-preview"
        "--colors=line:style:bold"
      ];
    };

    spotify-player = import ./misc/spotify-player.nix;

    zathura = import ./misc/zathura.nix;

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      options = [ "--cmd cd" ];
    };

    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batgrep
        batwatch
      ];
      syntaxes = {
        gleam = {
          src = pkgs.fetchFromGitHub {
            owner = "molnarmark";
            repo = "sublime-gleam";
            rev = "2e761cdb1a87539d827987f997a20a35efd68aa9";
            hash = "sha256-Zj2DKTcO1t9g18qsNKtpHKElbRSc9nBRE2QBzRn9+qs=";
          };
          file = "syntax/gleam.sublime-syntax";
        };
      };

      themes = {
        dracula = {
          src = pkgs.fetchFromGitHub {
            owner = "dracula";
            repo = "sublime"; # Bat uses sublime syntax for its themes
            rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
            sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
          };
          file = "Dracula.tmTheme";
        };
      };
    };
  };
}
