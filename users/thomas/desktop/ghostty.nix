{ pkgs, config, ... }:
{
  programs.ghostty-darwin = {
    enable = true;

    # installVimSyntax = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;

    themes = {
      iceberg-dark = {
        background = "161821";
        foreground = "c6c8d1";

        selection-background = "1e2132";
        selection-foreground = "c6c8d1";

        cursor-color = "#d2d4de";

        palette = [
          # black
          "0=#161821"
          "8=#6b7089"
          # red
          "1=#e27878"
          "9=#e98989"
          # green
          "2=#b4be82"
          "10=#c0ca8e"
          # yellow
          "3=#e2a478"
          "11=#e9b189"
          # blue
          "4=#84a0c6"
          "12=#91acd1"
          # magenta
          "5=#a093c7"
          "13=#ada0d3"
          # cyan
          "6=#89b8c2"
          "14=#95c4ce"
          # white
          "7=#c6c8d1"
          "15=#d2d4de"
        ];
      };
    };

    settings = {
      command = "${pkgs.lib.meta.getExe config.programs.fish.package}";

      background-opacity = 0.8;
      font-family = "FiraCode Nerd Font";
      font-size = 11.0;

      macos-titlebar-style = "hidden";
      theme = "iceberg-dark";

      window-padding-x = 12;
      window-padding-y = 12;
      window-theme = "ghostty";

      # clearDefaultKeybindings = true;
      keybind = [
        "ctrl+a>r=reload_config"

        "ctrl+a>shift+5=new_split:right"
        "ctrl+a>shift+'=new_split:down"

        "ctrl+j=goto_split:bottom"
        "ctrl+k=goto_split:top"
        "ctrl+h=goto_split:left"
        "ctrl+l=goto_split:right"

        "ctrl+a>z=toggle_split_zoom"

        "opt+j=resize_split:down,10"
        "opt+k=resize_split:up,10"
        "opt+h=resize_split:left,10"
        "opt+l=resize_split:right,10"
      ];
    };
  };
}
