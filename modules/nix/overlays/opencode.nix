{ inputs, ... }:

{
  nixpkgs.overlays = [
    inputs.opencode.overlays.default
  ];
}
