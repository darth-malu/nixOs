{pkgs, lib, config, ...}:
{

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  # services.httpd.enable = true;
  # services.httpd.adminAddr = "webmaster@example.org";
  # services.httpd.enablePHP = true; # oof... not a great idea in my opinion

  # services.httpd.virtualHosts."maluware.org" = {
  #   documentRoot = "/var/www/example.org";
  #   # want ssl + a let's encrypt certificate? add `forceSSL = true;` right here
  # };

  services.mysql.enable = true;
  services.mysql.package = pkgs.mariadb;

  # hacky way to create our directory structure and index page... don't actually use this
  # systemd.tmpfiles.rules = [
  #   "d /var/www/example.org"
  #   "f /var/www/example.org/index.php - - - - <?php phpinfo();"
  # ];
# }

  environment.systemPackages = with pkgs; [
    # zulip
    # zulip-term
  ];

}
