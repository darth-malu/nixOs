{
  Emacs = {
    name = "maluEmacs";
    terminal = false; # terminal app?
    #prefersNonDefaultGPU = true; # if true prefers powerful discrete gpu
    type = "Application"; # Link, Directory, Application
    categories = [
      "Development"
      "TextEditor"
    ];
    startupNotify = true;
    comment = "Its working lol"; # tooltip for the entry
    exec = "emacsclient -c %U";
    icon = "emacs";
    mimeType = [
      "text/english"
      "text/plain"
      "text/x-makefile"
      "text/x-c++hdr"
      "text/x-c++src"
      "text/x-chdr"
      "text/x-csrc"
      "text/x-java"
      "text/x-moc"
      "text/x-pascal"
      "text/x-tcl"
      "text/x-tex"
      "application/x-shellscript"
      "text/x-c"
      "text/x-c++"
    ];
  };
}
