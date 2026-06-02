{pkgs}:

pkgs.writeShellScriptBin "mpris_notif" ''
  sleep 1; echo "It actually works lol" | ${pkgs.cowsay}/bin/cowsay | ${pkgs.lolcat}/bin/lolcat
''

