{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  name = "Justin Malu";
  maildir = "/home/malu/Documents/Mail"; # can be relative from ~ so just 'MailDir' or absolute
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
          userName = "${email}"; # server username of this account
          flavor = "gmail.com";
          passwordCommand = "gpg -d $HOME/Shibuya/modules/home/programs/textEditor/emacs/mu4e_password.gpg";
          primary = true;
          # gpg.encryptByDefault = true;
          mbsync = {
            enable = true;
            create = "both"; # create missing mailboxes within the given mail store, --> one of "none", "maildir", "imap", "both"
            expunge = "both"; # Permanently remove messages marked for deletion from the given mail store.
            remove = "both"; # Propagate mailbox deletions to the given mail store
            patterns = [
              # patterns of mailboxes to synchronize
              "*"
              # "[Gmail]*"
            ]; # "[Gmail]/Sent Mail" ];
          };
          realName = "${name}";
          msmtp.enable = true; # If enabled then it is possible to use the --account command line option to send a message for a given account using the msmtp or msmtpq tool. For example, msmtp --account=private would send using the account defined in accounts.email.accounts.private. If the --account option is not given then the primary account will be used.
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
