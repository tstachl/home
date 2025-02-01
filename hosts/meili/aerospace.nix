{
  services.aerospace = {
    enable = true;
    settings = {
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
        alt-t = "workspace T"; # Terminal
        alt-m = "workspace M"; # Mail
        alt-s = "workspace S"; # Signal
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
        alt-shift-s = "move-node-to-workspace S";
        alt-shift-v = "move-node-to-workspace V";

        alt-shift-f = "fullscreen";

        # focus between windows
        alt-h = "focus left";
        alt-l = "focus right";
        alt-k = "focus up";
        alt-j = "focus down";

        # move between windows
        alt-shift-h = "move left";
        alt-shift-l = "move right";
        alt-shift-k = "move up";
        alt-shift-j = "move down";

        alt-shift-minus = "resize smart -50";
        alt-shift-equal = "resize smart +50";

        alt-tab = "workspace-back-and-forth";
        alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

        alt-shift-semicolon = "mode service";

        alt-slash = "layout tiles horizontal vertical";
        alt-comma = "layout accordion horizontal vertical";
      };

      mode.service.binding = {
        esc = ["reload-config" "mode main"];
        r = ["flatten-workspace-tree" "mode main"];
        f = ["layout floating tiling" "mode main"];
        backspace = ["close-all-windows-but-current" "mode main"];

        alt-shift-h = ["join-with left" "mode main"];
        alt-shift-j = ["join-with down" "mode main"];
        alt-shift-k = ["join-with up" "mode main"];
        alt-shift-l = ["join-with right" "mode main"];
      };

      on-window-detected = [
        {
          "if".app-id = "org.whispersystems.signal-desktop";
          check-further-callbacks = false;
          run = [ "move-node-to-workspace S" ];
        }
        {
          "if".app-id = "com.apple.finder";
          check-further-callbacks = false;
          run = [ "move-node-to-workspace E" ];
        }
        {
          "if".app-id = "com.apple.mail";
          check-further-callbacks = false;
          run = [ "move-node-to-workspace M" ];
        }
        {
          "if".app-id = "com.mitchellh.ghostty";
          check-further-callbacks = false;
          run = [ "move-node-to-workspace T" ];
        }
      ];
    };
  };
}
