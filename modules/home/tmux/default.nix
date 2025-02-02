{ pkgs-unstable, ...}:
{
  programs.tmux = {
    enable = true;
    package = pkgs-unstable.tmux;
    prefix = "M-w";
    # shortcut = "w"; # used with Ctrl alone?
    # aggressiveResize = true; # size of smallest session
    keyMode = "vi";
    sensibleOnTop = true; # run sensioble on top of config
    mouse = true;
    newSession = true; # spawn new session on attach empty
    disableConfirmationPrompt = true;
    clock24 = false;
    historyLimit = 9000; ##2000
    # reverseSplit = true; #TODO:test this, no work
    plugins = with pkgs-unstable.tmuxPlugins; [
      yank
      { plugin = catppuccin; extraConfig = import ./catppuccin.nix; }
      { plugin = vim-tmux-navigator; }
      # { plugin = tmuxPlugins.tmux-yank-unstable; }
      # { plugin = tmuxPlugins.tmux-floatx; }
      {
        plugin = resurrect;
        extraConfig = /*tmux*/''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-capture-pane-contents 'on'
          # set -g @resurrect-processes '~nvim -> nvim'
         '';
      }
      {
       plugin = continuum;
       extraConfig = /*tmux*/ ''
         set -g @continuum-restore 'on' # autorestore session on tmux a
         set -g @continuum-save-interval '5' # minutes
         # set -g @continuum-boot 'on'
       '';
      }
    ];
    # unbind C-b
    extraConfig = import ./extra.nix;
  };
}
