{
  pkgs,
  config,
  lib,
  ...
}:

let
  ghosttyCatppuccinSrc = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "ghostty";
    rev = "9e38fc2";
    sha256 = "sha256-RlgTeBkjEvZpkZbhIss3KxQcvt0goy4WU+w9d2XCOnw=";
  };
in

{
  xdg.configFile = {
    "ghostty/themes/catppuccin-frappe.conf".text =
      lib.strings.fileContents
        (ghosttyCatppuccinSrc + "/themes/catppuccin-frappe.conf");
    
    "ghostty/themes/catppuccin-latte.conf".text =
      lib.strings.fileContents
        (ghosttyCatppuccinSrc + "/themes/catppuccin-latte.conf");

    "ghostty/themes/catppuccin-macchiato.conf".text =
      lib.strings.fileContents
        (ghosttyCatppuccinSrc + "/themes/catppuccin-macchiato.conf");

    "ghostty/themes/catppuccin-mocha.conf".text =
      lib.strings.fileContents
        (ghosttyCatppuccinSrc + "/themes/catppuccin-mocha.conf");
  };

  programs.ghostty = {
    enable = true;
    package = null;

    installBatSyntax = false;
    installVimSyntax = false;

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

      background-opacity = 0.9;
      font-family = "FiraCode Nerd Font";
      font-size = 11.0;

      macos-titlebar-style = "hidden";
      theme = "catppuccin-mocha";

      window-padding-balance = true;
      window-padding-color = "extend";
      window-padding-x = 5;
      window-padding-y = 0;
      window-theme = "ghostty";
    };
  };
}
