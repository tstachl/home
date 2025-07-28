{ pkgs
, config
, lib
, ...
}: {
  programs.tmux = {
    sensibleOnTop = false;

    baseIndex = 1;
    clock24 = true;
    enable = true;
    escapeTime = 10;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    shell = "${lib.getExe config.programs.fish.package}";
    terminal = "tmux-256color";

    plugins = with pkgs.tmuxPlugins; [
      sensible
      tmux-select-pane-no-wrap
      vim-tmux-navigator
      yank
      {
        plugin = tmux-floax;
        extraConfig = ''
          set -g @floax-bind '-n C-`'
        '';
      }
      {
        plugin = kanagawa;
        extraConfig = ''
          set -g @kanagawa-theme 'dragon'
          set -g @kanagawa-refresh-rate 60
          set -g @kanagawa-show-left-icon window
          set -g @kanagawa-show-battery true
          set -g @kanagawa-show-powerline true
          set -g @kanagawa-show-location false
          set -g window-style 'fg=colour250'
        '';
      }
    ];

    extraConfig = ''
      # split windows on the current path
      unbind %
      unbind '"'
      bind-key %      split-window -h -c '#{pane_current_path}'
      bind-key '"'    split-window -v -c '#{pane_current_path}'

      # resize pane with vim motion keys
      bind -r h resize-pane -L 1
      bind -r l resize-pane -R 1
      bind -r j resize-pane -D 1
      bind -r k resize-pane -U 1

      # change width of left status bar to allow space for session names
      set -g status-left-length 30

      # - Put this in your ~/.tmux.conf and replace XXX by your $TERM outside of tmux:
      set-option -sa terminal-features ',xterm-256color:RGB'

      # default layout
      # set-hook -g after-new-window 'split-window -v -p 20'
    '';
  };
}
