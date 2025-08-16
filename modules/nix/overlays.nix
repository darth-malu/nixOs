{ pkgs, ... }:

{
  nixpkgs.overlays = [
    # (self: super: {
    #   gnome = super.gnome.overrideScope' (
    #     gself: gsuper: {
    #       nautilus = gsuper.nautilus.overrideAttrs (nsuper: {
    #         buildInputs =
    #           nsuper.buildInputs
    #           ++ (with gst_all_1; [
    #             gst-plugins-good
    #             gst-plugins-bad
    #             gst-plugins-ugly
    #             gst-libav
    #           ]);
    #       });
    #     }
    #   );
    # })
  ];
}
