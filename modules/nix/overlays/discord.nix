{ lib, pkgs, ... }:
let
  sources = (lib.importJSON ./discord-src.json)."linux-stable";
  # generate new hash with every major change
  # nix store prefetch-file <discord-download-url>
  # TODO: try nix-prefetch-url --type sha256 <url>
  # use blank hash and wait for error
in
{

  nixpkgs.overlays = [
    (final: prev: {
      discord = prev.discord.overrideAttrs (oldAttrs: {
        version = sources.version;
        src = prev.fetchurl {
          inherit (sources) url hash;
        };
      });
    })
  ];

  environment.systemPackages = with pkgs; [
    discord
  ];
}
