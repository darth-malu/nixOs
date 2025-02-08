{ pkgs, ...}:
{
  programs.tmux = {
    enable = true;
    prefix = "M-w";
    # shortcut = "w"; # used with Ctrl alone?
    # aggressiveResize = true; # size of smallest session
    keyMode = "vi";
    terminal =  "tmux-256color"; # screen::
    shell = "\${pkgs.bash}/bin/bash";
    tmuxinator.enable = true;
    baseIndex = 1;
    escapeTime = 0; # 500::
    focusEvents = true;
    sensibleOnTop = true; # run sensioble on top of config
    mouse = true;
    # newSession = true; # spawn new session on attach empty
    disableConfirmationPrompt = true;
    clock24 = false;
    historyLimit = 9000; # 2000
    reverseSplit = true; # does not work
    plugins = with pkgs.tmuxPlugins; [
      yank
      { plugin = catppuccin; extraConfig = import ./catppuccin.nix; }
      # { plugin = tmuxPlugins.tmux-yank-unstable; }
      # { plugin = tmuxPlugins.tmux-floatx; }
      # {
        # plugin = resurrect;
        # extraConfig = /*bash*/''
      #     set -g @resurrect-strategy-nvim 'session'
      #     set -g @resurrect-strategy-vim 'session'
          # set -g @resurrect-capture-pane-contents 'on'
      #     # set -g @resurrect-processes '~nvim -> nvim'
         # '';
      # }
      {
       plugin = continuum;
       extraConfig = /*bash*/ ''
         set -g @continuum-restore 'on' # autorestore session on tmux a
         set -g @continuum-save-interval '5' # minutes
         # set -g @continuum-boot 'on'
       '';
      }
    ];
    extraConfig = import ./extra.nix;
  };
}
