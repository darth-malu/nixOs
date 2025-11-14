{pkgs, lib, config, ...}:
{

services.mysql = {
  enable = true;
  package = pkgs.mariadb;
};

environment.systemPackages = with pkgs; [
  zulip
  zulip-term
];

}
