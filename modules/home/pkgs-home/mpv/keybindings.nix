{
  "ctrl+a" = "script-message osc-visibility cycle";
  "ctrl+f" = "script-binding subtitle_lines/list_subtitles";
  "tab" = "script-binding uosc/toggle-ui";
  "menu" = "script-binding uosc/menu";
  "mbtn_right" = "script-binding uosc/menu";
  # "mbtn_left" = "space cycle pause; show-text \"\${filename}\n\${time-pos} / \${duration} (\${percent-pos}%)\"; osd-bar show-progress";
  "mbtn_left" = "space cycle pause; show-progress";
  "s" = "script-binding uosc/subtitles"; # ! Subtitles
  "a" = "script-binding uosc/audio"; # ! Audio tracks
  "q" = "script-binding uosc/stream-quality"; # ! Stream quality
  "p" = "script-binding uosc/items"; # ! Playlist
  "c" = "script-binding uosc/chapters"; # ! Chapters
  "alt+>" = "script-binding uosc/delete-file-next"; # ! Navigation > Delete file & Next
  "alt+<" = "script-binding uosc/delete-file-prev"; # ! Navigation > Delete file & Prev
  "alt+esc" = "script-binding uosc/delete-file-quit"; # ! Navigation > Delete file & Quit
  "o" = "script-binding uosc/open-file"; # ! Navigation > Open file
  #           set video-aspect-override "-1"         #! Utils > Aspect ratio > Default
  #           set video-aspect-override "16:9"       #! Utils > Aspect ratio > 16:9
  #           set video-aspect-override "4:3"        #! Utils > Aspect ratio > 4:3
  #           set video-aspect-override "2.35:1"     #! Utils > Aspect ratio > 2.35:1
  #           script-binding uosc/audio-device       #! Utils > Audio devices
  #           script-binding uosc/editions           #! Utils > Editions
  "ctrl+s" = "async screenshot"; # ! Utils > Screenshot
  "alt+i" = "script-binding uosc/keybinds"; # ! Utils > Key bindings
  "O" = "script-binding uosc/show-in-directory"; # ! Utils > Show in directory
  #           script-binding uosc/open-config-directory #! Utils > Open config directory
  #           script-binding uosc/update             #! Utils > Update uosc
  "esc" = "quit"; # ! Quit
}
