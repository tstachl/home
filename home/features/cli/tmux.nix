{ pkgs
, config
, lib
, ...
}:
let
  isDarwin = pkgs.stdenv.isDarwin;
  reattach-to-user-namespace = lib.getExe' pkgs.reattach-to-user-namespace "reattach-to-user-namespace";
  tmux-sessionizer = lib.getExe config.programs.tmux.sessionizer.package;
in
{
  programs.tmux = {
    sensibleOnTop = true;

    baseIndex = 1;
    clock24 = true;
    enable = true;
    escapeTime = 10;
    keyMode = "vi";
    mouse = true;
    prefix = "C-Space";
    shell = "${lib.getExe config.programs.fish.package}";
    terminal = "tmux-256color";

    sessionizer.enable = true;
    sessionizer.searchPaths = [ "~/workspace" ];
    sessionizer.maxDepth = 2;

    plugins = with pkgs.tmuxPlugins; [
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
          set -g @kanagawa-ignore-window-colors true
        '';
      }
    ];

    extraConfig = ''
      ${lib.optionalString isDarwin ''
        # sensible plugin assumes $SHELL is /bin/sh
        # --- Darwin-Specific Settings (Raw Tmux Commands) ---
        # This block is only included if the system is Darwin
        set-option -g default-command "${reattach-to-user-namespace} -l $SHELL"
      ''}

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

      # additional keybindings for tmux-sessionizer
      bind-key -r M-h run-shell "tmux neww ${tmux-sessionizer} -s 0"
      bind-key -r M-t run-shell "tmux neww ${tmux-sessionizer} -s 1"
      bind-key -r M-n run-shell "tmux neww ${tmux-sessionizer} -s 2"
      bind-key -r M-s run-shell "tmux neww ${tmux-sessionizer} -s 3"
    '';
  };
}
