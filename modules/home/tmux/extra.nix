/* bash */
''
  set -s escape-time 0 # increase on slow connection

  # Increase scrollback buffer size from 2000 to 50000 lines
  # set -g history-limit 500000 # in options? hist size

  # Increase tmux messages display duration from 750ms to 4s
  # set -g display-time 4000

  # Refresh 'status-left' and 'status-right' more often, from every 15s to 5s
  # set -g status-interval 5

  # Focus events enabled for terminals that support them
  # set -g focus-events on
  set -g renumber-window on

  # bind-key -n C-h previous-window
  # bind-key -n C-n next-window
  # bind-key -n C-Space kill-window
  # bind-key -n M-Left previous-window
  # bind-key - M-Right next-window
  # bind-key -n M-j previous-window
  # bind-key -n M-k next-window
  # bind-key -n M-n new-window
  # bind-key -n M-H previous-window
  bind-key -n M-h previous-window
  bind-key -n M-l next-window
  bind-key -n M-Enter new-window -c "#{pane_current_path}" 
  bind-key -n M-Escape kill-window
  # bind-key -n M-Space kill-window
  # bind-key -n M-x kill-window
  # bind-key -n M-q kill-window
  # bind-key -n C-Tab next-window
  # bind-key -n C-S-Tab previous-window
  # bind-key -n M-S-l select-window -t :+  # Next window (Meta+Shift+L)
  # bind-key -n M-S-h select-window -t :-  # Previous window (Meta+Shift+H)
  # bind-key -r G run-shell "path-to-harpoon/harpoon/scripts/tmux/switch-back-to-nvim" #TODO:harpoon term later

  bind \` switch-client -t'{marked}'
  bind c new-window -c "#{pane_current_path}" # keep currentpath on new window
  bind Space last-window #focuscurrentlast lul
  bind C-Space switch-client -l # focuscurrentlast session

  # host during ssh as title
  # set -g set-titles on
  # set -g set-titles-string "#T"

  # gen conf
  set -g base-index 1
  setw -g pane-base-index 1

  set -g status-position top
  # setw -g aggressive-resize on
  # set -g allow-rename off
  #set -g set-clipboard on # system clipboard
  set -g detach-on-destroy off  # don't exit from tmux when closing a session
  set -g default-command "''${SHELL}" #non-login shell , solves compositor stderr?
  set -g default-terminal "tmux-256color"
  # set -g default-terminal "xterm-256color"
  # set -g default-terminal 'xterm-kitty'
  # set -ag terminal-overrides ',xterm-256color*:RGB'
''
