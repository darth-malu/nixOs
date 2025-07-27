{ pkgs, ... }:
{
  programs.mbsync = {
    enable = true;
    extraConfig = ''
      IMAPAccount gmail
      Host imap.gmail.com
      User justinmalu@gmail.com
      PassCmd "cat ~/Documents/goin"
      # SSLType IMAPS
      TLSType IMAPS
      CertificateFile /etc/ssl/certs/ca-certificates.crt

      IMAPStore gmail-remote
      Account gmail

      MaildirStore gmail-local
      Subfolders Verbatim
      Path ~/Documents/Mail/
      Inbox ~/Documents/Mail/Inbox

      # With mbsync 1.4.0 and later: Use 'Far' instead of 'Master', and
      # 'Near' instead of 'Slave'.
      Channel gmail
      Far :gmail-remote:
      Near :gmail-local:
      Patterns * ![Gmail]* "[Gmail]/Sent Mail" "[Gmail]/Starred" "[Gmail]/All Mail" "[Gmail]/Trash"
      Create Both
      SyncState *
      # SSLVersions TLSv1.2
    '';
    # groups = {
    # };
  };

  services.mbsync = {
    enable = true;
    # preExec = "mkdir -p ~/Documents/Mail";
    postExec = "${pkgs.mu}/bin/mu index";
  };
}
