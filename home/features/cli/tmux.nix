{ pkgs, config, ... }:
{
  # - WARNING Neither Tc nor RGB capability set. True colors are disabled. |'termguicolors'| won't work properly.
  #   - ADVICE:
  #     - Put this in your ~/.tmux.conf and replace XXX by your $TERM outside of tmux:
  #       set-option -sa terminal-features ',XXX:RGB'
  #     - For older tmux versions use this instead:
  #       set-option -ga terminal-overrides ',XXX:Tc'

  programs.tmux = {
    sensibleOnTop = false;

    baseIndex = 1;
    clock24 = true;
    enable = true;
    escapeTime = 10;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    # shell = "${pkgs.fish}/bin/fish";
    shell = "${pkgs.lib.meta.getExe config.programs.fish.package}";
    terminal = "tmux-256color";

    plugins = with pkgs.tmuxPlugins; [
      pkgs.more-tmux-plugins.tmux-select-pane-no-wrap
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor 'frappe' # latte, frappe, macchiato or mocha
        '';
      }
      vim-tmux-navigator
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
