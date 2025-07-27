{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;

    settings = {
      env = {
        LC_ALL = "en_US.UTF-8";
        LC_CTYPE = "en_US.UTF-8";
        TERM = "xterm-256color";
      };

      font = {
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "FiraCode Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "FiraCode Nerd Font";
          style = "Bold Italic";
        };
        size = 11.0;
      };

      colors = {
        primary = {
          background = "#303446";
          foreground = "#c6d0f5";
          dim_foreground = "#838ba7";
          bright_foreground = "#c6d0f5";
        };

        cursor = {
          text = "#303446";
          cursor = "#f2d5cf";
        };

        vi_mode_cursor = {
          text = "#303446";
          cursor = "#babbf1";
        };

        search.matches = {
          foreground = "#303446";
          background = "#a5adce";
        };

        search.focused_match = {
          foreground = "#303446";
          background = "#a6d189";
        };

        footer_bar = {
          foreground = "#303446";
          background = "#a5adce";
        };

        hints.start = {
          foreground = "#303446";
          background = "#e5c890";
        };

        hints.end = {
          foreground = "#303446";
          background = "#a5adce";
        };

        selection = {
          text = "#303446";
          background = "#f2d5cf";
        };

        normal = {
          black = "#51576d";
          red = "#e78284";
          green = "#a6d189";
          yellow = "#e5c890";
          blue = "#8caaee";
          magenta = "#f4b8e4";
          cyan = "#81c8be";
          white = "#b5bfe2";
        };

        bright = {
          black = "#626880";
          red = "#e78284";
          green = "#a6d189";
          yellow = "#e5c890";
          blue = "#8caaee";
          magenta = "#f4b8e4";
          cyan = "#81c8be";
          white = "#a5adce";
        };

        # indexed_colors = {
        #   index = 16;
        #   color = "#ef9f76";
        # };
        #
        # indexed_colors = {
        #   index = 17;
        #   color = "#f2d5cf";
        # };
      };

      bell = {
        animation = "EaseOutExpo";
        duration = 400;
        color = "#ffffff";
      };

      window = {
        padding = {
          x = 12;
          y = 12;
        };
        opacity = 0.8;
      };

      terminal.shell = {
        program = "${pkgs.fish}/bin/fish";
        args = [ "--login" ];
      };

      keyboard.bindings = [
        {
          key = "Space";
          mods = "Shift";
          mode = "~Search";
          action = "ToggleViMode";
        }

        # TODO: figure out why I set these
        # { key = "Up"; mods = "Alt"; chars = "\x1b[1;5A"; }
        # { key = "Down"; mods = "Alt"; chars = "\x1b[1;5B"; }
        # { key = "Left"; mods = "Alt"; chars = "\x1bb"; }
        # { key = "Right"; mods = "Alt"; chars = "\x1bf"; }
        # { key = "A"; mods = "Alt"; chars = "\x1ba"; }
        # { key = "B"; mods = "Alt"; chars = "\x1bb"; }
        # { key = "C"; mods = "Alt"; chars = "\x1bc"; }
        # { key = "D"; mods = "Alt"; chars = "\x1bd"; }
        # { key = "E"; mods = "Alt"; chars = "\x1be"; }
        # { key = "F"; mods = "Alt"; chars = "\x1bf"; }
        # { key = "G"; mods = "Alt"; chars = "\x1bg"; }
        # { key = "H"; mods = "Alt"; chars = "\x1bh"; }
        # { key = "I"; mods = "Alt"; chars = "\x1bi"; }
        # { key = "J"; mods = "Alt"; chars = "\x1bj"; }
        # { key = "K"; mods = "Alt"; chars = "\x1bk"; }
        # { key = "L"; mods = "Alt"; chars = "\x1bl"; }
        # { key = "M"; mods = "Alt"; chars = "\x1bm"; }
        # { key = "N"; mods = "Alt"; chars = "\x1bn"; }
        # { key = "O"; mods = "Alt"; chars = "\x1bo"; }
        # { key = "P"; mods = "Alt"; chars = "\x1bp"; }
        # { key = "Q"; mods = "Alt"; chars = "\x1bq"; }
        # { key = "R"; mods = "Alt"; chars = "\x1br"; }
        # { key = "S"; mods = "Alt"; chars = "\x1bs"; }
        # { key = "T"; mods = "Alt"; chars = "\x1bt"; }
        # { key = "U"; mods = "Alt"; chars = "\x1bu"; }
        # { key = "V"; mods = "Alt"; chars = "\x1bv"; }
        # { key = "W"; mods = "Alt"; chars = "\x1bw"; }
        # { key = "X"; mods = "Alt"; chars = "\x1bx"; }
        # { key = "Y"; mods = "Alt"; chars = "\x1by"; }
        # { key = "Z"; mods = "Alt"; chars = "\x1bz"; }
        # { key = "Key0"; mods = "Alt"; chars = "º"; }
        # { key = "Key1"; mods = "Alt"; chars = "¡"; }
        # { key = "Key2"; mods = "Alt"; chars = "€"; }
        # { key = "Key3"; mods = "Alt"; chars = "#"; }
        # { key = "Key4"; mods = "Alt"; chars = "¢"; }
        # { key = "Key5"; mods = "Alt"; chars = "∞"; }
        # { key = "Key6"; mods = "Alt"; chars = "§"; }
        # { key = "Key7"; mods = "Alt"; chars = "¶"; }
        # { key = "Key8"; mods = "Alt"; chars = "•"; }
        # { key = "Key9"; mods = "Alt"; chars = "ª"; }
      ];
    };
  };
}
