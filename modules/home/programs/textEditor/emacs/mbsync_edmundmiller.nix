{
  config,
  options,
  lib,
  pkgs,
  ...
}:

with lib;
let
  name = "Justin Malu";
  maildir = "/home/malu/Documents/Mail";
  email = "justinmalu@gmail.com";
in
{
  options.emacs-mail = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.emacs-mail.enable {
    home.packages = with pkgs; [
      mu
      isync
    ];
    accounts.email = {
      maildirBasePath = "${maildir}";
      accounts = {
        Gmail = {
          address = "${email}";
          userName = "${email}";
          flavor = "gmail.com";
          # passwordCommand = "${pkgs.pass}/bin/pass Email/GmailApp";
          passwordCommand = "cat ~/Documents/goin";
          primary = true;
          # gpg.encryptByDefault = true;
          mbsync = {
            enable = true;
            create = "both";
            expunge = "both";
            patterns = [
              "*"
              "[Gmail]*"
            ]; # "[Gmail]/Sent Mail" ];
          };
          realName = "${name}";
          msmtp.enable = true;
        };
      };
    };

    programs = {
      msmtp.enable = true;
      mbsync.enable = true;
    };

    services = {
      mbsync = {
        enable = true;
        frequency = "*:0/15";
        preExec = "${pkgs.isync}/bin/mbsync -Ha";
        postExec = "${pkgs.mu}/bin/mu index -m ${maildir}";
      };
    };
  };
}
