{ pkgs, ... }:
{
  environment.etc = {
    "inputrc" = {
      text = pkgs.lib.mkDefault (
        pkgs.lib.mkAfter ''
          #$include /etc/Inputrc

          # experiment
          # str: text color and background
          # set active-region-start-color \e[01;33m # bright red - not all readline shows hightlight of region

          # undoes the effect of start-color to normal terminal
          # set active-region-end-color

          set completion-display-width 100 # width of completion columns, 80;;

          # - and _ as same if completion-ignore-case is on
          set completion-map-case on

          # ellipses past char number in common prefix
          # set completion-prefix-display-length 2

          # should be displayed message, possibilities, default 100
          set completion-query-items 150

          # default on, 8-bit char
          # set enable-meta-key on

          # tilde expansion on word completion, def: off
          # set expand-tilde on

          set print-completions-horizontally on # like zsh?

          # Vi
          set editing-mode vi
          set keymap vi-insert  # start in insert mode
          set show-mode-in-prompt on

          # 1 - begin , 2 -end
          # set vi-ins-mode-string (ins)\1\e[6 q\2
          # set vi-cmd-mode-string (cmd)\1\e[2 q\2
          # set vi-ins-mode-string \1\e[34;1m\2└──[ins] \1\e[0m\2
          # set vi-cmd-mode-string \1\e[33;1m\2└──[cmd] \1\e[0m\2

          # set vi-ins-mode-string \1\e[5 q\e]12;pink\a\2
          set vi-ins-mode-string \1\e[5 q\e]12;green\a\2
          set vi-cmd-mode-string \1\e[1 q\e]12;orange\a\2
          # set vi-cmd-mode-string \1\e[1 q\e]12;purple\a\2

          $if mode=vi
            "\e[D":  backward-char
            "\M-[C": forward-char
            "\eh":   backward-char # M-h go to normal mode then move one char
            "\M-l":  forward-char  # M-l
            "\e[5~": history-search-backward # page up
            "\e[6~": history-search-forward  # page down

            "\C-x\"": "\"\"\C-b" # FIXME
            # C-j - RET - enter for next line instead enter lol best shortcut fr like # alot of conflict eg tmux
            # "\C-l":"clear\n"
          $endif

          $if Bash
            "C-q":  quoted-insert # Insert the next character literally, ignoring its special meaning.
            "\e[A": history-search-backward # up arrow
            "\e[B": history-search-forward # down arrow

            # prepare to type a quoted word --
            # insert open and close double quotes
            # and move to just after the open quote
            "\C-x\"": "\"\"\C-b"

            # Quote the current or previous word
            "\C-xq": "\eb\"\ef\""

            # Add a binding to refresh the line, which is unbound
            "\C-xr": redraw-current-line

            # Edit variable on current line.
            "\M-\C-v": "\C-a\C-k$\C-y\M-\C-e\C-a\C-y="
          $endif

          # Arrows
          # \e[D - Left
          # \e[C - Right
          # \e[A - Up
          # \e[B - Down

          # Arrow keys in 8 bit keypad mode
          #
          #"\M-\C-OD":       backward-char
          #"\M-\C-OC":       forward-char
          #"\M-\C-OA":       previous-history
          #"\M-\C-OB":       next-history
          #
          # Arrow keys in 8 bit ANSI mode
          #
          #"\M-\C-[D":       backward-char
          #"\M-\C-[C":       forward-char
          #"\M-\C-[A":       previous-history
          #"\M-\C-[B":       next-history

          set show-all-if-unmodified On #single tab instead of double tab

          # complete word, show possible compleetions if still ambiguous
          set show-all-if-ambiguous On

          set completion-ignore-case on

          #security by preventing accidental execution of control characters in text, \e[200~ at the beginning and \e[201~ at the end
          set enable-bracketed-paste on # fix weird double indent?

          set echo-control-characters of control char as symbol rather than command when off, eg. C-l to clear to work need off

          # Color files by types

          # Note that this may cause completion text blink in some terminals (e.g. xterm).
          set colored-stats On #use LS_COLORS

          set visible-stats On # Append char to indicate type

          set mark-symlinked-directories On
          set colored-completion-prefix On # color common prefix cmp
          set menu-complete-display-prefix On # show shared prefix

          # suffix for file type like with ls -F
          set page-completions off # pager like show of many possible completions

        ''
      );
    };
  };
}

# Legend
# SET THE MODE STRING AND CURSOR TO INDICATE THE VIM MODE
#   FOR THE NUMBER AFTER `\e[`:
#     0: blinking block
#     1: blinking block (default)
#     2: steady block
#     3: blinking underline
#     4: steady underline
#     5: blinking bar (xterm)
#     6: steady bar (xterm)
#TODO: C-q test
