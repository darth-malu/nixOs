{pkgs,...}:
  let
    timerly = pkgs.vimUtils.buildVimPlugin {
        name = "timerly";
        src = pkgs.fetchFromGitHub {
            owner = "siduck";
            repo = "timerly";
            rev = "6a25eec63ca42491de4706587b84182e85e6e7f4";
            hash = "sha256-fPfLNxbSX3i8lQYQcyRTxtu/BMRcGZ7/n00+4BZ7A5I=";
            # mode: m, toggle status: <leader>, increment: <up>, decrement: <down>, reset: <BS>
        };
      };
      volt = pkgs.vimUtils.buildVimPlugin {
        name = "volt";
        src = pkgs.fetchFromGitHub {
          owner = "siduck";
          repo = "volt";
          hash = "sha256-LW3w95QkgIbtP753d/6+nUBpEfIQ+IXqwTg4Tiv9mHc=";
          rev = "e01090ff27b34288574c24a09cb166e47c4a0c3d";
        };
      };
      minty = pkgs.vimUtils.buildVimPlugin {
        name = "minty";
        src = pkgs.fetchFromGitHub {
          owner = "siduck";
          repo = "minty";
          hash = "sha256-U6IxF/i1agIGzcePYg/k388GdemBtA7igBUMwyQ3d3I=";
          rev = "6dce9f097667862537823d515a0250ce58faab05";
        };
      };
      typr = pkgs.vimUtils.buildVimPlugin {
        name = "minty";
        src = pkgs.fetchFromGitHub {
          owner = "siduck";
          repo = "typr";
          hash = "sha256-S1k+EAs8k0RjdLEG1EqtK7IhfuRy7JFJ/hQOR5wLXsU=";
          rev = "58449f11cb7a1b3b6857b49b2fcb56bc04919b3f";
        };
      };
  in
{
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
      #vim-nix
      volt
      timerly
      # typr
      # minty
    ];
}
