{pkgs, lib, config, ...}:
{

  environment.systemPackages = with pkgs; [
    # zulip
    # zulip-term
  ];

}
