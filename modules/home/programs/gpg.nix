{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # pinentry
    # pinentry-all
    # pinentry-rofi
    # pinentry-qt
    # pinentry-tty
    pinentry-emacs
    # pinentry-curses
    # gcr # fix for pinentry on non-gnome systems
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableBashIntegration = true;
    enableExtraSocket = true;
    extraConfig = ''
      allow-emacs-pinentry
      allow-loopback-pinentry
    '';
    # verbose = true;
    pinentry = {
      program = "pinentry-emacs";
      # package = pkgs.pinentry-gnome3;
    };
  };

  programs = {
    # Gui for OpenPGP
    # seahorse.enable = true;
    gpg = {
      enable = true;

      # homedir = "/home/userName/.config/gnupg";
      settings = {
        # Default/trusted key ID (helpful with throw-keyids)
        # Example, you will put your own keyid here
        # Use `gpg --list-keys`
        # default-key = "0x37ACBCDA569C5C44788";
        # trusted-key = "0x37ACBCDA569C5C44788";
        # https://github.com/drduh/config/blob/master/gpg.conf
        # https://www.gnupg.org/documentation/manuals/gnupg/GPG-Configuration-Options.html
        # https://www.gnupg.org/documentation/manuals/gnupg/GPG-Esoteric-Options.html
        # Some Best Practices, stronger algos etc
        # Use AES256, 192, or 128 as cipher
        # personal-cipher-preferences = "AES256 AES192 AES";
        # Use SHA512, 384, or 256 as digest
        # personal-digest-preferences = "SHA512 SHA384 SHA256";
        # Use ZLIB, BZIP2, ZIP, or no compression
        # personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
        # Default preferences for new keys
        # default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
        # SHA512 as digest to sign keys
        # cert-digest-algo = "SHA512";
        # SHA512 as digest for symmetric ops
        # s2k-digest-algo = "SHA512";
        # AES256 as cipher for symmetric ops
        # s2k-cipher-algo = "AES256";
        # UTF-8 support for compatibility
        # charset = "utf-8";
        # Show Unix timestamps
        # fixed-list-mode = "";
        # No comments in signature
        # no-comments = ""; # FALSE?
        # No version in signature
        # no-emit-version = "";
        # Disable banner
        # no-greeting = "";
        # Long hexidecimal key format
        # keyid-format = "0xlong";
        # Display UID validity
        # list-options = "show-uid-validity";
        # verify-options = "show-uid-validity";
        # Display all keys and their fingerprints
        # with-fingerprint = "";
        # Cross-certify subkeys are present and valid
        # require-cross-certification = "";
        # Disable caching of passphrase for symmetrical ops
        # no-symkey-cache = "";
        # Enable smartcard
        # use-agent = "";
      };
    };
  };
}
