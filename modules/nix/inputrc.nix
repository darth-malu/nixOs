{ lib, ... }:
{
  # INSPO:
  # +
  # https://deut-erium.github.io/2024/01/28/inputrc.html
  # Source the .inputrc
  # bind -f ~/.inputrc

  environment.etc = {
    "inputrc" = {
      text = lib.mkDefault (
        lib.mkAfter ''
          #$include /etc/Inputrc

          # experiment
          # str: text color and background
          # set active-region-start-color \e[01;33m # bright red - not all readline shows hightlight of region

          # undoes the effect of start-color to normal terminal
          # set active-region-end-color

          # width of completion columns, 80;;
          set completion-display-width 100

          # - and _ as same if completion-ignore-case is on
          set completion-map-case on
          set completion-ignore-case on

          # ellipses past char number in common prefix
          # set completion-prefix-display-length 2

          # should be displayed message, possibilities, default 100
          set completion-query-items 150

          # default on, 8-bit char
          # set enable-meta-key on

          # tilde expansion on word completion, def: off
          # set expand-tilde on

          set print-completions-horizontally on

          set blink-matching-paren on

          # VIM
          # 1 - begin , 2 -end
          # set editing-mode vi

          $if mode=vi
            set vi-ins-mode-string \1\e[5 q\e]12;green\a\2
            set vi-cmd-mode-string \1\e[1 q\e]12;orange\a\2
            set keymap vi-insert 
            set show-mode-in-prompt on
            # Movement
            "\C-a": beginning-of-line      # Ctrl + A
            "\C-e": end-of-line            # Ctrl + E
            "\M-b": backward-word          # Alt + B (M stands for Meta/Alt)
            "\M-f": forward-word           # Alt + F

            TAB: menu-complete
            # shift tab to menu complete backward
            "\e[Z": menu-complete-backward

            # "\C-w": backward-kill-word     # Ctrl + W (Cut word backward)

            "\M-p": yank                   # Ctrl + Y (Paste / Yank back)

            "\C-k": previous-history
            "\C-j": next-history
            "\C-l": clear-screen

            "\e[5~": beginning-of-history
            "\e[6~": end-of-history

            # "\C-x\"": "\"\"\C-b" 
            # "\C-o\"": "\"\"\\C-b" 
            # C-j - RET - enter for next line instead enter lol best shortcut fr like # alot of conflict eg tmux -- just use C-m
            # "\C-l": "clear\n"

            # "\ew": "\C-l \C-e # macro" # TODO test
            # "\e\C-l": "\C-e | less\C-m"
            # "\es": "\C-a su -c '\C-e'\C-m"
            # "\e\C-y": "\C-ayes | \C-m"
            # "\es": "\C-asudo \C-e"

            set keymap vi-command
            "\C-k": previous-history
            "\C-j": next-history
            "gg": beginning-of-history
            "G" : end-of-history
            # Editing / Killing
            "D": kill-line              # Ctrl + K (Cut to end of line)
            "dw": kill-word
            "db": backward-kill-word
            # change line -> delete then go in insert mode
            "C":  "Da"
            "cw": "dwi"         # change word
            "cb": "dbi"         # change word backward
            # go into insert mode, re run last command with !! and press enter
            ".": "i!!\r"
            "|": "A | "
            # vi equivalent of delete all word i.e delete the current word entirely
            "daw": "lbdW"
            "yaw": "lbyW"

            # change all word, delete and edit the current word
            "caw": "lbcW"

            # delete inner word (word under the cursor without the surrounding whitespaces)
            "diw": "lbdw"
            # yank inner word
            "yiw": "lbyw"
            # change inner word
            "ciw": "lbcw"

            # delete around double quoted string -> delete the text in double quoted strings and the quotes themselves
            # F search backward for a double quote, then delete till first forward search of double quotes
            "da\"": "lF\"df\""

            # delete inside double quoted string -> delete the text inside the double quoted strings but not the quotes
            "di\"": "lF\"lmtf\"d`t"
            # change inside double quoted string basically delete inside double quoted string and go in insert mode
            "ci\"": "di\"i"

            # change around double quoted string
            "ca\"": "da\"i"

            # delete around single quoted string
            "da'": "lF'df'"
            "di'": "lF'lmtf'd`t"
            "ci'": "di'i"
            "ca'": "da'i"

            # delete around tilde
            "da`": "lF\`df\`"
            "di`": "lF\`lmtf\`d`t"
            "ci`": "di`i"
            "ca`": "da`i"

            # delete around parenthesis
            "da(": "lF(df)"
            "di(": "lF(lmtf)d`t"
            "ci(": "di(i"
            "ca(": "da(i"
            "da)": "lF(df)"
            "di)": "lF(lmtf)d`t"
            "ci)": "di(i"
            "ca)": "da(i"

            # delete around curly
            "da{": "lF{df}"
            "di{": "lF{lmtf}d`t"
            "ci{": "di{i"
            "ca{": "da{i"
            "da}": "lF{df}"
            "di}": "lF{lmtf}d`t"
            "ci}": "di}i"
            "ca}": "da}i"

            # delete around square brackets
            "da[": "lF[df]"
            "di[": "lF[lmtf]d`t"
            "ci[": "di[i"
            "ca[": "da[i"
            "da]": "lF[df]"
            "di]": "lF[lmtf]d`t"
            "ci]": "di]i"
            "ca]": "da]i"

            # delete around angled brackets
            "da<": "lF<df>"
            "di<": "lF<lmtf>d`t"
            "ci<": "di<i"
            "ca<": "da<i"
            "da>": "lF<df>"
            "di>": "lF<lmtf>d`t"
            "ci>": "di>i"
            "ca>": "da>i"

            # delete around forward slash
            "da/": "lF/df/"
            "di/": "lF/lmtf/d`t"
            "ci/": "di/i"
            "ca/": "da/i"

            # delete around colon
            "da:": "lF:df:"
            "di:": "lF:lmtf:d`t"
            "ci:": "di:i"
            "ca:": "da:i"

          $endif

          $if Bash
            # Insert the next character literally, ignoring its special meaning.
            # "C-q":  quoted-insert
            "\e[A": history-search-backward
            "\e[B": history-search-forward
            # prepare to type a quoted word --
            # insert open and close double quotes
            # and move to just after the open quote
            # TODO FIXME works but weird...investigate
            # "\C-x\"": "\"\C-b\""

            # Quote the current or previous word
            # "\C-xq": "\eb\"\ef\""

            # Add a binding to refresh the line, which is unbound
            # "\C-xr": redraw-current-line

            # Edit variable on current line
            # "\M-\C-v": "\C-a\C-k$\C-y\M-\C-e\C-a\C-y=" # FIXME
            # "\C-x\C-e": edit-and-execute-command 
          $endif


          #single tab instead of double tab
          set show-all-if-unmodified on

          # complete word, show possible compleetions if still ambiguous
          set show-all-if-ambiguous on

          #security by preventing accidental execution of control characters in text, \e[200~ at the beginning and \e[201~ at the end
          set enable-bracketed-paste on # fix weird double indent?

          # control char as symbol rather than command when off, eg. C-l to clear to work need off
          set echo-control-characters off

          # Color files by types NOTE that this may cause completion text blink in some terminals (e.g. xterm).
          # sets the readline to display possible completions using different colors to indicate filetypes determined from env variable LC_COLORS
          set colored-stats on

          # Append char to indicate type
          set visible-stats on

          set mark-symlinked-directories on

          # color common prefix cmp
          set colored-completion-prefix on

          # show shared prefix
          set menu-complete-display-prefix on

          # suffix for file type like with ls -F
          set page-completions off # pager like show of many possible completions

          # Set the bell-style to be visible only i.e no audio played on command completion
          # can also be set to none
          # visible is stupid
          set bell-style none  
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

# PGUP PGDOWN
# "\e[5~": history-search-backward
# "\e[6~": history-search-forward
