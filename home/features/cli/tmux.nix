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
      tmux-select-pane-no-wrap
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor 'frappe' # latte, frappe, macchiato or mocha
          set -g @catppuccin_window_text " #W"
          set -g @catppuccin_window_current_text " #W"
        '';
      }
      vim-tmux-focus-events
      vim-tmux-navigator
      {
        plugin = tmux-floax;
        extraConfig = ''
          set -g @floax-bind '-n C-`'
        '';
      }
      {
        plugin = yank;
        extraConfig = ''
          bind-key -T copy-mode-vi v send-keys -X begin-selection
          bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
          bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
        '';
      }
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
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
      set-hook -g after-new-window 'split-window -v -p 20'
    '';
  };
}
