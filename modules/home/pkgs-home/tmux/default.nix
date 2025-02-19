{ pkgs, ...}:
{
  programs.tmux = {
    enable = true;
    prefix = "M-w";
    # shortcut = "w"; # used with Ctrl alone?
    # aggressiveResize = true; # size of smallest session
    keyMode = "vi";
    terminal =  "xterm-256color"; # screen::
    # shell = "\${pkgs.bash}/bin/bash";
    tmuxinator.enable = false; # using resurrect for this
    baseIndex = 1;
    escapeTime = 0; # 500::
    focusEvents = true;
    sensibleOnTop = true; # run sensioble on top of config
    mouse = true;
    # newSession = true; # spawn new session on attach empty
    disableConfirmationPrompt = true;
    clock24 = false;
    historyLimit = 9000; # 2000
    # reverseSplit = true; # does not work
    plugins = with pkgs.tmuxPlugins; [
      # yank
      { plugin = catppuccin; extraConfig = import ./catppuccin.nix; }
      { plugin = vim-tmux-navigator; }
      # { plugin = tmuxPlugins.tmux-yank-unstable; }
      # { plugin = tmuxPlugins.tmux-floatx; }
      {
        plugin = resurrect;
        extraConfig = /*bash*/''
          # fix attempt
          resurrect_dir="$HOME/.tmux/resurrect"
          set -g @resurrect-dir $resurrect_dir
          set -g @resurrect-hook-post-save-all 'target=$(readlink -f $resurrect_dir/last); sed "s| --cmd .*-vim-pack-dir||g; s|/etc/profiles/per-user/$USER/bin/||g; s|/home/$USER/.nix-profile/bin/||g" $target | sponge $target'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-capture-pane-contents 'on'
          # set -g @resurrect-processes '~nvim -> nvim'
         '';
      }
      {
       plugin = continuum;
       extraConfig = /*bash*/ ''
         set -g @continuum-restore 'on' # autorestore session on tmux a
         set -g @continuum-save-interval '10' # minutes
         # set -g @continuum-boot 'on' # needed for restore after boot?
       '';
      }
    ];
    extraConfig = import ./extra.nix;
  };
}
