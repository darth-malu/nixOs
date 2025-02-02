# use nix-prefetch-git
{pkgs}:

pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner
  };
};
