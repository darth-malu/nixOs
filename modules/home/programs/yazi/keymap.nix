{
  input.keymap = [
    {
      on = [ "<Esc>" ];
      run = "escape";
      desc = "Back to normal mode, or cancel input";
    }
    {
      on = [ "<C-c>" ];
      run = "close";
      desc = "Cancel Input";
    }
    {
      on = [ "<Enter>" ];
      run = "close --submit";
      desc = "Submit Input";
    }

    # Mode
    {
      on = [ "i" ];
      run = "insert";
      desc = "Enter insert mode";
    }
    {
      on = [ "I" ];
      run = [
        "move first-char"
        "insert"
      ];
      desc = "Move to BOL,and enter insert mode";
    }
    {
      on = [ "a" ];
      run = "insert --append";
      desc = "Enter append mode";
    }
    {
      on = [ "A" ];
      run = [
        "move eol"
        "insert --append"
      ];
      desc = "Move to EOL, and enter append mode";
    }
    {
      on = [ "v" ];
      run = "visual";
      desc = "Enter visual mode";
    }
    {
      on = [ "r" ];
      run = "replace";
      desc = "Replace a single character";
    }

    # Delete
    {
      on = [ "<Backspace>" ];
      run = "backspace";
      desc = "Delete char before cursor";
    }
    {
      on = [ "<Delete>" ];
      run = "backspace --under";
      desc = "Delete char under cursor";
    }
    {
      on = [ "<C-d>" ];
      run = "backspace --under";
      desc = "Delete char under cursor";
    }

    {
      on = [ "<C-d>" ];
      run = "backspace --under";
      desc = "Delete char under cursor";
    }

    # character wise movement
    {
      on = [ "h" ];
      run = "move -1";
      desc = "Move back a char";
    }
    {
      on = [ "l" ];
      run = "move 1";
      desc = "Move forward a char";
    }
    {
      on = [ "<C-b>" ];
      run = "move -1";
      desc = "Move back a char";
    }
    {
      on = [ "<C-f>" ];
      run = "move 1";
      desc = "Move forward a char";
    }
    {
      on = [ "<Left>" ];
      run = "move -1";
      desc = "Move back a char";
    }
    {
      on = [ "<Right>" ];
      run = "move 1";
      desc = "Move forward a char";
    }

    # selection
    {
      on = "V";
      run = [
        "move bol"
        "visual"
        "move eol"
      ];
      desc = "Select from BOL to EOL";
    }
    {
      on = "<C-A>";
      run = [
        "move eol"
        "visual"
        "move bol"
      ];
      desc = "Select from EOL to BOL";
    }
    {
      on = "<C-E>";
      run = [
        "move bol"
        "visual"
        "move eol"
      ];
      desc = "Select from BOL to EOL";
    }

    # Word-wise movement
    {
      on = "b";
      run = "backward";
      desc = "Move back to the start of the current or previous word";
    }
    {
      on = "B";
      run = "backward wide";
      desc = "Move back to the start of the current or previous WORD";
    }
    {
      on = "w";
      run = "forward";
      desc = "Move forward to the start of the next word";
    }
    {
      on = "W";
      run = "forward wide";
      desc = "Move forward to the start of the next WORD";
    }
    {
      on = "e";
      run = "forward --end-of-word";
      desc = "Move forward to the end of the current or next word";
    }
    {
      on = "E";
      run = "forward wide --end-of-word";
      desc = "Move forward to the end of the current or next WORD";
    }
    {
      on = "<A-b>";
      run = "backward lean";
      desc = "Move back to the start of the current or previous word";
    }
    {
      on = "<A-f>";
      run = "forward lean --end-of-word";
      desc = "Move forward to the end of the current or next word";
    }
    {
      on = "<C-Left>";
      run = "backward lean";
      desc = "Move back to the start of the current or previous word";
    }
    {
      on = "<C-Right>";
      run = "forward lean --end-of-word";
      desc = "Move forward to the end of the current or next word";
    }

    # Line-wise movement
    {
      on = "0";
      run = "move bol";
      desc = "Move to the BOL";
    }
    {
      on = "$";
      run = "move eol";
      desc = "Move to the EOL";
    }
    {
      on = "_";
      run = "move first-char";
      desc = "Move to the first non-whitespace character";
    }
    {
      on = "^";
      run = "move first-char";
      desc = "Move to the first non-whitespace character";
    }
    {
      on = "<C-a>";
      run = "move bol";
      desc = "Move to the BOL";
    }
    {
      on = "<C-e>";
      run = "move eol";
      desc = "Move to the EOL";
    }
    {
      on = "<Home>";
      run = "move bol";
      desc = "Move to the BOL";
    }
    {
      on = "<End>";
      run = "move eol";
      desc = "Move to the EOL";
    }

    # Cut/Yank/Paste
    {
      on = "d";
      run = "delete --cut";
      desc = "Cut selected characters";
    }
    {
      on = "D";
      run = [
        "delete --cut"
        "move eol"
      ];
      desc = "Cut until EOL";
    }
    {
      on = "c";
      run = "delete --cut --insert";
      desc = "Cut selected characters, and enter insert mode";
    }
    {
      on = "C";
      run = [
        "delete --cut --insert"
        "move eol"
      ];
      desc = "Cut until EOL, and enter insert mode";
    }
    {
      on = "s";
      run = [
        "delete --cut --insert"
        "move 1"
      ];
      desc = "Cut current character, and enter insert mode";
    }
    {
      on = "S";
      run = [
        "move bol"
        "delete --cut --insert"
        "move eol"
      ];
      desc = "Cut from BOL until EOL, and enter insert mode";
    }
    {
      on = "x";
      run = [
        "delete --cut"
        "move 1 --in-operating"
      ];
      desc = "Cut current character";
    }
    {
      on = "y";
      run = "yank";
      desc = "Copy selected characters";
    }
    {
      on = "p";
      run = "paste";
      desc = "Paste copied characters after the cursor";
    }
    {
      on = "P";
      run = "paste --before";
      desc = "Paste copied characters before the cursor";
    }

    # Undo/Redo/Casefy
    {
      on = "u";
      run = [
        "undo"
        "casefy lower"
      ];
      desc = "Undo, or lowercase if in visual mode";
    }
    {
      on = "U";
      run = "casefy upper";
      desc = "Uppercase";
    }
    {
      on = "<C-r>";
      run = "redo";
      desc = "Redo the last operation";
    }

    # History
    {
      on = "k";
      run = "recall -1";
      desc = "Recall previous input";
    }
    {
      on = "j";
      run = "recall 1";
      desc = "Recall next input";
    }
    {
      on = "<Up>";
      run = "recall -1";
      desc = "Recall previous input";
    }
    {
      on = "<Down>";
      run = "recall 1";
      desc = "Recall next input";
    }
    {
      on = "<C-p>";
      run = "recall -1";
      desc = "Recall previous input";
    }
    {
      on = "<C-n>";
      run = "recall 1";
      desc = "Recall next input";
    }

    # Help
    {
      on = "~";
      run = "help";
      desc = "Open help";
    }
    {
      on = "<F1>";
      run = "help";
      desc = "Open help";
    }
  ];

  confirm.keymap = [
    {
      on = "<Esc>";
      run = "close";
      desc = "Cancel the confirm";
    }
    {
      on = "<C-[>";
      run = "close";
      desc = "Cancel the confirm";
    }
    {
      on = "<C-c>";
      run = "close";
      desc = "Cancel the confirm";
    }
    {
      on = "<Enter>";
      run = "close --submit";
      desc = "Submit the confirm";
    }

    {
      on = "n";
      run = "close";
      desc = "Cancel the confirm";
    }
    {
      on = "y";
      run = "close --submit";
      desc = "Submit the confirm";
    }

    {
      on = "k";
      run = "arrow prev";
      desc = "Previous line";
    }
    {
      on = "j";
      run = "arrow next";
      desc = "Next line";
    }

    {
      on = "<Up>";
      run = "arrow prev";
      desc = "Previous line";
    }
    {
      on = "<Down>";
      run = "arrow next";
      desc = "Next line";
    }

    # Help
    {
      on = "~";
      run = "help";
      desc = "Open help";
    }
    {
      on = "<F1>";
      run = "help";
      desc = "Open help";
    }
  ];
  cmp.keymap = [
    {
      on = "<C-c>";
      run = "close";
      desc = "Cancel completion";
    }
    {
      on = "<Tab>";
      run = "close --submit";
      desc = "Submit the completion";
    }
    {
      on = "<Enter>";
      run = [
        "close --submit"
        "input:close --submit"
      ];
      desc = "Complete and submit the input";
    }

    {
      on = "<A-k>";
      run = "arrow prev";
      desc = "Previous item";
    }
    {
      on = "<A-j>";
      run = "arrow next";
      desc = "Next item";
    }

    {
      on = "<Up>";
      run = "arrow prev";
      desc = "Previous item";
    }
    {
      on = "<Down>";
      run = "arrow next";
      desc = "Next item";
    }

    {
      on = "<C-p>";
      run = "arrow prev";
      desc = "Previous item";
    }
    {
      on = "<C-n>";
      run = "arrow next";
      desc = "Next item";
    }

    # Help
    {
      on = "~";
      run = "help";
      desc = "Open help";
    }
    {
      on = "<F1>";
      run = "help";
      desc = "Open help";
    }
  ];
  mgr.keymap = [
    {
      on = [
        "g"
        "c"
      ];
      run = "cd ~/.config";
      desc = ".config";
    }
    {
      on = [
        "g"
        "d"
      ];
      run = "cd ~/Documents";
      desc = "Documents";
    }
    {
      on = [
        "g"
        "x"
      ];
      run = "cd ~/Downloads";
      desc = "Go to the downloads directory";
    }
    {
      on = [
        "g"
        "h"
      ];
      run = "cd ~";
      desc = "Go to the home directory";
    }
    {
      on = [
        "g"
        "b"
      ];
      run = "cd /media/Hyogo/Pictures/grimblast";
      desc = "grimblast";
    }
    {
      on = [
        "g"
        "m"
      ];
      run = "cd ~/Music";
      desc = "MUSIC";
    }
    {
      on = [
        "g"
        "M"
      ];
      run = "cd /media/";
      desc = "media directory";
    }
    {
      on = [
        "g"
        "p"
      ];
      run = "cd ~/Pictures";
      desc = "Go to the pictures directory";
    }
    {
      on = [
        "g"
        "r"
      ];
      run = "cd ~/Projects";
      desc = "~/Projects";
    }
    {
      on = [
        "g"
        "s"
      ];
      run = "cd ~/Projects/Shibuya";
      desc = "~/Shibuya";
    }
    {
      on = [
        "g"
        "u"
      ];
      run = "cd ~/Projects/USIU";
      desc = "USIU 📚";
    }
    {
      on = [
        "g"
        "v"
      ];
      run = "cd ~/Videos";
      desc = "VIDEOS dir";
    }
    {
      on = [
        "g"
        "<Space>"
      ];
      run = "cd --interactive";
      desc = "Go to a directory interactively";
    }
    {
      on = [
        "g"
        "t"
      ];
      run = "follow";
      desc = "Follow hovered symlink";
    }

    {
      on = [ "<Esc>" ];
      run = "escape";
      desc = "Exit visual mode, clear selected, or cancel search";
    }
    {
      on = [ "q" ];
      run = "quit";
      desc = "Exit the process";
    }
    {
      on = [ "Q" ];
      run = "quit --no-cwd-file";
      desc = "Exit the process without writing cwd-file";
    }
    {
      on = [ "<C-x>" ];
      run = "close";
      desc = "Close the current tab; or quit if it is last tab";
    }
    {
      on = [ "<C-z>" ];
      run = "suspend";
      desc = "Suspend the process";
    }

    {
      on = [ "k" ];
      run = "arrow -1";
      desc = "Move cursor up";
    }
    {
      on = [ "j" ];
      run = "arrow 1";
      desc = "Move cursor down";
    }
    {
      on = [ "h" ];
      run = "leave";
      desc = "parent dir. go";
    }
    {
      on = [ "l" ];
      run = "enter";
      desc = "@darth Enter child dir.";
    }

    {
      on = [ "<Left>" ];
      run = "leave";
      desc = "Go back to the parent directory";
    }
    {
      on = [ "<Right>" ];
      run = "plugin smart-enter";
      desc = "Enter the child directory (smart)";
    }

    {
      on = [ "K" ];
      run = "arrow -5";
      desc = "Move cursor up 5 lines";
    }
    {
      on = [ "J" ];
      run = "arrow 5";
      desc = "Move cursor down 5 lines";
    }

    # { on = [ "<C-u>" ]; run = "arrow -50%";  desc = "Move cursor up half page"; }
    # { on = [ "<C-d>" ]; run = "arrow 50%";   desc = "Move cursor down half page"; }
    # { on = [ "<C-b>" ]; run = "arrow -100%"; desc = "Move cursor up one page"; }
    # { on = [ "<C-f>" ]; run = "arrow 100%";  desc = "Move cursor down one page"; }

    {
      on = [ "<Up>" ];
      run = "arrow -1";
      desc = "Move cursor up";
    }
    {
      on = [ "<Down>" ];
      run = "arrow 1";
      desc = "Move cursor down";
    }

    {
      on = [
        "g"
        "g"
      ];
      run = "arrow top";
      desc = "Move cursor to the top";
    }
    {
      on = [ "G" ];
      run = "arrow bot";
      desc = "Move cursor to the bottom";
    }

    # { on = [ "K" ];   run = "seek -5"; desc = "Seek up 5 units in the preview"; }
    # { on = [ "J" ]; run = "seek 5";  desc = "Seek down 5 units in the preview"; }
    {
      on = [ "<A-k>" ];
      run = "seek -5";
      desc = "Seek up 5 units in the preview";
    }
    {
      on = [ "<A-j>" ];
      run = "seek 5";
      desc = "Seek down 5 units in the preview";
    }

    {
      on = [ "<Space>" ];
      run = [
        "toggle"
        "arrow 1"
      ];
      desc = "Toggle the current selection state";
    }

    {
      on = [ "v" ];
      run = "visual_mode";
      desc = "Enter visual mode (selection mode)";
    }
    {
      on = [ "V" ];
      run = "visual_mode --unset";
      desc = "Enter visual mode (unset mode)";
    }

    {
      on = [ "<C-a>" ];
      run = "toggle_all --state=on";
      desc = "Select all files";
    }
    {
      on = [ "<C-r>" ];
      run = "toggle_all --state=off";
      desc = "Inverse selection of all files";
    }

    {
      on = [ "o" ];
      run = "open";
      desc = "Open the selected files";
    }
    {
      on = [ "O" ];
      run = "open --interactive";
      desc = "Open the selected files interactively";
    }
    {
      on = [ "<Enter>" ];
      run = "open --hovered";
      desc = "Always open the hovered file regardless of the selection state.";
    }
    {
      on = [ "<C-Enter>" ];
      run = "open --interactive";
      desc = "Open the selected files interactively";
    }

    {
      on = [ "y" ];
      run = [
        "escape --visual"
        "yank"
      ];
      desc = "Copy the selected files";
    }
    {
      on = [ "Y" ];
      run = "unyank";
      desc = "Cancel the yank status of files";
    }
    {
      on = [ "x" ];
      run = [
        "escape --visual"
        "yank --cut"
      ];
      desc = "Cut the selected files";
    }
    {
      on = [ "p" ];
      run = "paste";
      desc = "Paste the files";
    }
    {
      on = [ "P" ];
      run = "paste --force";
      desc = "Paste the files (overwrite if the destination exists)";
    }

    {
      on = [ "-" ];
      run = "link";
      desc = "Symlink the absolute path of yanked files";
    }
    {
      on = [ "_" ];
      run = "link --relative";
      desc = "Symlink the relative path of yanked  files";
    }

    {
      on = [ "d" ];
      run = [
        "escape --visual"
        "remove"
      ];
      desc = "Move the files to the trash";
    }
    {
      on = [ "D" ];
      run = [
        "escape --visual"
        "remove --permanently"
      ];
      desc = "Permanently delete the files";
    }

    {
      on = [ "a" ];
      run = "create";
      desc = "Create a file or directory (ends with / for directories)";
    }
    {
      on = [ "A" ];
      run = "bulk_create";
      desc = "bulk create files";
    }
    {
      on = [ "r" ];
      run = [
        "escape --visual"
        "rename --cursor=before_ext"
      ];
      desc = "Rename a file or directory";
    }

    # { on = [ "b" ];         run = [ "escape --visual"  "shell -- 'wl-copy \"$@\"'" "shell 'notify-send This \"$@\"'" ];                      desc = "Run a shell --interactive command"; }
    {
      on = [ ";" ];
      run = [
        "escape --visual"
        "shell --interactive"
      ];
      desc = "Run a shell --interactive command";
    }
    {
      on = [ ":" ];
      run = [
        "escape --visual"
        "shell --block --interactive"
      ];
      desc = "Run a shell command (block until finishes)";
    }
    #{ on = [ ":" ];         run = [ "escape --visual"; "shell --block" ];              desc = "Run a shell command (block the UI until the command finishes);" }

    {
      on = [ "." ];
      run = "hidden toggle";
      desc = "Toggle the visibility of hidden files";
    }
    {
      on = [ "s" ];
      run = "search --via=fd";
      desc = "Search files by name via fd";
    }
    {
      on = [ "S" ];
      run = "search --via=rg";
      desc = "Search files by content via ripgrep";
    }
    {
      on = [ "<C-s>" ];
      run = "search none";
      desc = "Cancel the ongoing search";
    }
    {
      on = [ "z" ];
      run = "plugin zoxide";
      desc = "Jump to a directory using zoxide";
    }
    {
      on = [ "Z" ];
      run = "plugin fzf";
      desc = "Jump to a directory, or reveal a file using fzf";
    }

    {
      on = [
        "L"
        "s"
      ];
      run = "linemode size";
      desc = "Set linemode to size";
    }
    {
      on = [
        "L"
        "p"
      ];
      run = "linemode permissions";
      desc = "Set linemode to permissions";
    }
    {
      on = [
        "L"
        "m"
      ];
      run = "linemode mtime";
      desc = "Set linemode to mtime";
    }
    {
      on = [
        "L"
        "b"
      ];
      run = "linemode btime";
      desc = "Set linemode to btime";
    }
    {
      on = [
        "L"
        "n"
      ];
      run = "linemode none";
      desc = "Set linemode to none";
    }

    {
      on = [
        "c"
        "c"
      ];
      run = [
        "escape --visual"
        "copy path"
      ];
      desc = "Copy the absolute path";
    }
    {
      on = [
        "c"
        "d"
      ];
      run = [
        "escape --visual"
        "copy dirpath"
      ];
      desc = "Copy directory path";
    }
    {
      on = [
        "c"
        "D"
      ];
      run = [
        "escape --visual"
        "copy dirurl"
      ];
      desc = "Copy directory url";
    }
    {
      on = [
        "c"
        "f"
      ];
      run = [
        "escape --visual"
        "copy filename"
      ];
      desc = "Copy filename";
    }
    {
      on = [
        "c"
        "n"
      ];
      run = [
        "escape --visual"
        "copy name_without_ext"
      ];
      desc = "Copy filename without the extension";
    }

    {
      on = [ "F" ];
      run = "filter --smart";
      desc = "Filter files";
    }

    {
      on = [ "~" ];
      run = "help";
      desc = "Open Help";
    }

    {
      on = "w";
      run = "tasks:show";
      desc = "Show task manager";
    }

    {
      on = [ "/" ];
      run = "find --smart";
      desc = "Find next file";
    }
    {
      on = [ "?" ];
      run = "find --previous --smart";
      desc = "Find previous file";
    }
    {
      on = [ "n" ];
      run = "find_arrow";
      desc = "Next Found";
    }
    {
      on = [ "N" ];
      run = "find_arrow --previous";
      desc = "Previous Found";
    }

    {
      on = [
        ","
        "m"
      ];
      run = [
        "sort mtime --reverse=no"
        "linemode mtime"
      ];
      desc = "Sort by modified time";
    }
    {
      on = [
        ","
        "M"
      ];
      run = [
        "sort mtime --reverse=yes --dir-first"
        "linemode mtime"
      ];
      desc = "Sort by modified time (reverse)";
    }
    {
      on = [
        ","
        "c"
      ];
      run = [
        "sort btime --reverse=no"
        "linemode btime"
      ];
      desc = "Sort by btime time";
    }
    {
      on = [
        ","
        "C"
      ];
      run = [
        "sort btime --reverse=yes --dir-first"
        "linemode btime"
      ];
      desc = "Sort by btime (reverse)";
    }
    {
      on = [
        ","
        "e"
      ];
      run = "sort extension --reverse=no";
      desc = "Sort by extension";
    }
    {
      on = [
        ","
        "E"
      ];
      run = "sort extension --reverse=yes";
      desc = "Sort by extension (reverse)";
    }
    {
      on = [
        ","
        "a"
      ];
      run = "sort alphabetical  --reverse=no";
      desc = "Sort alphabetically";
    } # 1<2<10
    {
      on = [
        ","
        "A"
      ];
      run = "sort alphabetical --reverse=yes";
      desc = "Sort alphabetically (reverse)";
    }
    {
      on = [
        ","
        "n"
      ];
      run = "sort natural --dir-first";
      desc = "Sort naturally";
    }
    {
      on = [
        ","
        "N"
      ];
      run = "sort natural --reverse --dir-first";
      desc = "Sort naturally (reverse)";
    }
    {
      on = [
        ","
        "s"
      ];
      run = [
        "sort size --dir-first"
        "linemode size"
      ];
      desc = "Sort by size";
    }
    {
      on = [
        ","
        "S"
      ];
      run = [
        "sort size --reverse --dir-first"
        "linemode size"
      ];
      desc = "Sort by size (reverse)";
    }
    {
      on = [
        ","
        "r"
      ];
      run = "sort random --reverse=no";
      desc = "Sort randomly";
    }

    {
      on = [ "T" ];
      run = "tab_create --current";
      desc = "Create a new tab using the $CWD";
    }
    {
      on = [
        "t"
        "r"
      ];
      run = "tab_rename --interactive";
      desc = "Rename the current tab";
    }
    {
      on = [ "T" ];
      run = "tab_create /home/malu";
      desc = "Create a new tab with HOME as CWD";
    } # If neither [path] nor --current is specified, will use the startup directory to create the tab.
    {
      on = [ "1" ];
      run = "tab_switch 0";
      desc = "Switch to the first tab";
    }
    {
      on = [ "2" ];
      run = "tab_switch 1";
      desc = "Switch to the second tab";
    }
    {
      on = [ "3" ];
      run = "tab_switch 2";
      desc = "Switch to the third tab";
    }
    {
      on = [ "4" ];
      run = "tab_switch 3";
      desc = "Switch to the fourth tab";
    }
    {
      on = [ "5" ];
      run = "tab_switch 4";
      desc = "Switch to the fifth tab";
    }
    {
      on = [ "6" ];
      run = "tab_switch 5";
      desc = "Switch to the sixth tab";
    }
    {
      on = [ "7" ];
      run = "tab_switch 6";
      desc = "Switch to the seventh tab";
    }
    {
      on = [ "8" ];
      run = "tab_switch 7";
      desc = "Switch to the eighth tab";
    }
    {
      on = [ "9" ];
      run = "tab_switch 8";
      desc = "Switch to the ninth tab";
    }
    {
      on = [ "[" ];
      run = "tab_switch -1 --relative";
      desc = "Switch to the previous tab";
    }
    {
      on = [ "]" ];
      run = "tab_switch 1 --relative";
      desc = "Switch to the next tab";
    }
    {
      on = [ "{" ];
      run = "tab_swap -1";
      desc = "Swap the current tab with the previous tab";
    }
    {
      on = [ "}" ];
      run = "tab_swap 1";
      desc = "Swap the current tab with the next tab";
    }

    {
      on = "<Tab>";
      run = "spot";
      desc = "Display file information with the preset or user-customized spotter.";
    }

  ];

  spot.keymap = [
    {
      on = "~";
      run = "help";
      desc = "Display file information with the preset or user-customized spotter.";
    }
    {
      on = "<Tab>";
      run = "close";
      desc = "Hide the spotter";
    }
    {
      on = "<Esc>";
      run = "close";
      desc = "Hide the spotter";
    }
    {
      on = "k";
      run = "arrow prev";
      desc = "Spot prev Item in directory";
    }
    {
      on = "j";
      run = "arrow next";
      desc = "Spot next Item in directory";
    }
    {
      on = "h";
      run = "swipe prev";
      desc = "Swipe to previous file";
    }
    {
      on = "l";
      run = "swipe next";
      desc = "Swipe to next file";
    }
    {
      on = "G";
      run = "arrow bot";
      desc = "Spot Last Item in directory";
    }
    {
      on = [
        "g"
        "g"
      ];
      run = "arrow top";
      desc = "Spot first Item in directory";
    }
    {
      on = "l";
      run = "swipe 1";
      desc = "swipe?";
    }
    {
      on = "h";
      run = "swipe -1";
      desc = "swipe?";
    }
    {
      on = [ "y" ];
      run = "copy cell";
      desc = "copy content from the spotter (the selected table cell)";
    }
  ];

  tasks.keymap = [
    {
      on = "w";
      run = "close";
      desc = "tasks inspector";
    }
    {
      on = "n";
      run = "show";
      desc = "Show the tasks manager";
    }
    {
      on = "~";
      run = "help";
      desc = "Open Help";
    }
    {
      on = "<Enter>";
      run = "inspect";
      desc = "Inspect the task";
    }
    {
      on = "x";
      run = "cancel";
      desc = "cancel the task";
    }
    {
      on = "up";
      run = "arrow prev";
      desc = "Previous Task";
    }
    {
      on = "down";
      run = "arrow next";
      desc = "Next Task";
    }
    {
      on = "k";
      run = "arrow prev";
      desc = "Previous Task";
    }
    {
      on = "j";
      run = "arrow next";
      desc = "Next Task";
    }
  ];

  mgr.prepend_keymap = [

    {
      on = [ "!" ];
      run = "shell \"$SHELL\" --block";
      desc = "open $SHELL here";
    }
    # {on = [ "y" ]; run = "shell -- for path in \"$@\"; do echo \"file://$path\"; done | wl-copy -t text/uri-list, \"yank\""; desc = "copy selected files to clipboard when copying";}

    {
      on = [ "<C-y>" ];
      run = "plugin wl-clipboard";
      desc = "Copy selected files to wl-clipboard";
    }

    {
      on = [ "<C-r>" ];
      run = "plugin drag";
      desc = "Drag files";
    }

    # A- Parent, B - Current, C - Preview
    {
      on = [ "<C-=>" ];
      run = "plugin toggle-pane max-current";
      desc = "Maximize B";
    }
    {
      on = [ "<C-->" ];
      run = "plugin toggle-pane min-preview";
      desc = "Minimize C";
    }

    {
      on = [ "l" ];
      run = "plugin smart-enter";
      desc = "Enter child dir or open file";
    }

    {
      on = [ "p" ];
      run = "plugin smart-paste";
      desc = "Paste into the hovered directory or CWD";
    }

    {
      on = [ "t" ];
      run = "plugin smart-tab";
      desc = "Create a tab and enter the hovered directory";
    }

    {
      on = [ "f" ];
      run = "plugin jump-to-char";
      desc = "Jump to char";
    }

    # {on = [ "m" ]; run = "plugin relative-motions"; desc = "Trigger a new relative motion";}

    # {on = [ "m" ]; run = "plugin bookmarks save"; desc = "Save current position as a bookmark";}
    # {on = [ "'" ]; run = "plugin bookmarks jump"; desc = "Jump to a bookmark";}
    # {on = [ "b" "d" ]; run = "plugin bookmarks delete"; desc = "Delete a bookmark";}
    # {on = [ "b" "D" ]; run = "plugin bookmarks delete_all"; desc = "Delete all bookmarks";}
    # {on = [ "g" "f" ]; run = "search_do --via=fd --args='-d 3'"; desc = "Switch to the flat view with a max depth of 3";} #NOTE unused

  ];

  input.prepend_keymap = [
    {
      on = [ "<Esc>" ];
      run = "close";
      desc = "Cancel input";
    }
  ];
}
