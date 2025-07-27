{ pkgs
, config
, lib
, ...
}:
let
  cfg = config.programs.aerospace;
  aerospace-focus = "${lib.getExe pkgs.aerospace-tmux-focus}";
in
{
  home.packages = [ pkgs.aerospace-tmux-focus ];

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

        alt-shift-semicolon = "mode service";

        alt-slash = "layout tiles horizontal vertical";
        alt-comma = "layout accordion horizontal vertical";
      };

      on-window-detected = [
        # disable on "Picture-in-Picture"
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.brave.Browser";
            window-title-regex-substring = "Picture in Picture";
          };
          run = [ "layout floating" ];
        }
      ];
    };
  };
}
