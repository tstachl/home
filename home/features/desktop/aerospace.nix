{ pkgs, config, lib, ... }:

let
  cfg = config.programs.aerospace;
  aerospace = "${pkgs.lib.meta.getExe cfg.package}";
  tmux = "${pkgs.lib.meta.getExe config.programs.tmux.package}";

  aerospace-focus-pkg = pkgs.writeShellScriptBin "aerospace-focus" ''
    direction="$1"

    if [[ -n "$(${aerospace} list-windows --focused | grep tmux)" ]]; then
      tmux_dir=""

      case "$direction" in
        left) tmux_dir="L" ;;
        down) tmux_dir="D" ;;
        up) tmux_dir="U" ;;
        right) tmux_dir="R" ;;
      esac

      if [[ -n "$tmux_dir" ]]; then
        ret=$(${tmux} run "#{at_edge} $tmux_dir")

        if [[ $ret -eq 1 ]]; then
          ${aerospace} focus "$direction"
        else
          ${tmux} select-pane "-$tmux_dir"
        fi
      fi
    fi

    ${aerospace} focus "$direction"
  '';

  aerospace-focus = "${pkgs.lib.meta.getExe aerospace-focus-pkg}";
in

{
  home.packages = [ aerospace-focus-pkg ];

  launchd.agents.aerospace = {
    enable = lib.mkForce true;
    config = {
      ProgramArguments = [
        "${cfg.package}/Applications/AeroSpace.app/Contents/MacOS/AeroSpace"
        "--started-at-login"
      ];
      KeepAlive = true;
      RunAtLoad = true;
    };
  };

  programs.aerospace = {
    enable = true;
    userSettings = {
      start-at-login = true;

      gaps = {
        inner.horizontal = 10;
        inner.vertical = 10;
        outer.left = 10;
        outer.bottom = 10;
        outer.top = 10;
        outer.right = 10;
      };

      mode.main.binding = {
        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-b = "workspace B"; # Browser
        alt-e = "workspace E"; # Finder
        alt-m = "workspace M"; # Mail
        alt-n = "workspace N"; # Notes
        alt-s = "workspace S"; # Signal
        alt-t = "workspace T"; # Terminal
        alt-v = "workspace V"; # Video

        # moving windows to workspaces
        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";
        alt-shift-5 = "move-node-to-workspace 5";
        alt-shift-b = "move-node-to-workspace B";
        alt-shift-e = "move-node-to-workspace E";
        alt-shift-t = "move-node-to-workspace T";
        alt-shift-m = "move-node-to-workspace M";
        alt-shift-n = "move-node-to-workspace N";
        alt-shift-s = "move-node-to-workspace S";
        alt-shift-v = "move-node-to-workspace V";

        alt-shift-f = "fullscreen";

        # focus between windows
        ctrl-h = "exec-and-forget ${aerospace-focus} left";
        ctrl-l = "exec-and-forget ${aerospace-focus} right";
        ctrl-k = "exec-and-forget ${aerospace-focus} up";
        ctrl-j = "exec-and-forget ${aerospace-focus} down";

        # move between windows
        ctrl-shift-h = "move left";
        ctrl-shift-l = "move right";
        ctrl-shift-k = "move up";
        ctrl-shift-j = "move down";

        alt-shift-minus = "resize smart -50";
        alt-shift-equal = "resize smart +50";

        alt-tab = "workspace-back-and-forth";
        alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

        alt-shift-semicolon = "mode service";

        alt-slash = "layout tiles horizontal vertical";
        alt-comma = "layout accordion horizontal vertical";
      };

      mode.service.binding = {
        esc = [
          "reload-config"
          "mode main"
        ];
        r = [
          "flatten-workspace-tree"
          "mode main"
        ];
        f = [
          "layout floating tiling"
          "mode main"
        ];
        backspace = [
          "close-all-windows-but-current"
          "mode main"
        ];

        alt-shift-h = [
          "join-with left"
          "mode main"
        ];
        alt-shift-j = [
          "join-with down"
          "mode main"
        ];
        alt-shift-k = [
          "join-with up"
          "mode main"
        ];
        alt-shift-l = [
          "join-with right"
          "mode main"
        ];
      };

      on-window-detected = [
        # {
        #   "if".app-id = "org.whispersystems.signal-desktop";
        #   check-further-callbacks = false;
        #   run = [ "move-node-to-workspace S" ];
        # }
        # {
        #   "if".app-id = "com.apple.finder";
        #   check-further-callbacks = false;
        #   run = [ "move-node-to-workspace E" ];
        # }
        # {
        #   "if".app-id = "com.apple.mail";
        #   check-further-callbacks = false;
        #   run = [ "move-node-to-workspace M" ];
        # }
        # {
        #   "if".app-id = "com.mitchellh.ghostty";
        #   check-further-callbacks = false;
        #   run = [ "move-node-to-workspace T" ];
        # }
        # disable on "Picture-in-Picture"
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "app.zen-browser.zen";
            window-title-regex-substring = "Picture-in-Picture";
          };
          run = [ "layout floating" ];
        }
      ];
    };
  };
}
