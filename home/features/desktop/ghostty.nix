{
  pkgs,
  config,
  ...
}:
{
  programs.ghostty = {
    enable = true;
    package = null;

    installBatSyntax = false;
    installVimSyntax = false;

    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;

    themes = {
      catppuccin-frappe = {
        palette = [
          "0=#51576d"
          "1=#e78284"
          "2=#a6d189"
          "3=#e5c890"
          "4=#8caaee"
          "5=#f4b8e4"
          "6=#81c8be"
          "7=#b5bfe2"
          "8=#626880"
          "9=#e78284"
          "10=#a6d189"
          "11=#e5c890"
          "12=#8caaee"
          "13=#f4b8e4"
          "14=#81c8be"
          "15=#a5adce"
        ];

        background = "303446";
        foreground = "c6d0f5";

        cursor-color = "f2d5cf";
        cursor-text = "303446";

        selection-background = "44495d";
        selection-foreground = "c6d0f5";
      };

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

      background-opacity = 0.9;
      font-family = "FiraCode Nerd Font";
      font-size = 11.0;

      macos-titlebar-style = "hidden";
      theme = "catppuccin-frappe";

      window-padding-x = 12;
      window-padding-y = 12;
      window-theme = "ghostty";
    };
  };
}
