{
  enable = true;
  enableBashIntegration = true; # true::
  tmux = {
    enableShellIntegration = true; # sets FZF_TMUX=1
    shellIntegrationOptions = [ "-p 50%,60%" ]; # -d 40% #TODO: see more # fzf-tmux --help
  };
  colors = {
    # https://github.com/junegunn/fzf/wiki/Color-schemes
    # bg -> background
    # bg+ -> current line background plus associated border
    # fg -> # text above current line - default text
    # fg + -> # text current line; ~ matched pattern
    # hl -> # highlighted substrings, ~ current line
    # hl+ -> # highlighted substrings(current line)
    # bg = "#1e1e1e";
    bg = "#022223";
    # "bg+" = "#9381ff";
    "bg+" = "#222436"; # #022223 - green, #222436 - tokyo
    # fg = "#93E1D8";
    # fg = "#4ED4BC";
    fg = "#4ED4BC";
    "fg+" = "#0FA3B1";
    # fg = "#9400FF";
    # "fg+" = "#d4d4d4";
    # "fg+" = "#DA4167";
    "gutter" = "#022223";
    # "hl" = "#0FA3B1";
    # "hl+" = "#F1DEDE";
    # "hl" = "#F7567C";
    "hl" = "#9400FF";
    "hl+" = "#FCFCFC";
    # "hl+" = "#9400FF";
    # "hl+" = "#4ED4BC";
    # "preview-fg" = "";
    # "preview-bg" = "";
    "pointer" = "#4F345A";
  };
  defaultCommand = "fd --type f";
  defaultOptions = [
    # FZF_DEFAULT_OPTS
    "--height 40%"
    "--border"
    # "--border none"
    # "--layout reverse"
    # "--tmux center;60%;50%  --layout reverse" #--tmux is silently ignored when you're not on tmux.# reverse; reverse-list
    # "--style minimal"
    # "--cycle"
    # "--gap 1"
    # "--scroll-off=4"
  ];
  changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ]; # M-c binding
  # changeDirWidgetCommand = "fd --type d";
  # fileWidgetCommand = "fd --type f"; #C-t #FIXME: broken $FZF_DEFAULT_OPTS: invalid command line string
  # fileWidgetOptions = ["preview 'head {}"];
  historyWidgetOptions = [
    "--sort"
    "--exact"
  ];
}
