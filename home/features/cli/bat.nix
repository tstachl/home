{ pkgs, ... }:

let
  catppuccin-src = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "bat";
    rev = "699f60f";
    sha256 = "sha256-6fWoCH90IGumAMc4buLRWL0N61op+AuMNN9CAR9/OdI=";
  };
in

{
  programs.bat = {
    enable = true;
    config = {
      theme = "catppuccin-frappe";
    };

    themes = {
      catppuccin-latte = {
        src = catppuccin-src;
        file = "/themes/Catppuccin Latte.tmTheme";
      };

      catppuccin-frappe = {
        src = catppuccin-src;
        file = "/themes/Catppuccin Frappe.tmTheme";
      };

      catppuccin-macchiato = {
        src = catppuccin-src;
        file = "/themes/Catppuccin Macchiato.tmTheme";
      };

      catppuccin-mocha = {
        src = catppuccin-src;
        file = "/themes/Catppuccin Mocha.tmTheme";
      };

      nord = {
        src = pkgs.fetchFromGitHub {
          owner = "crabique";
          repo = "Nord-plist";
          rev = "0d655b23d6b300e691676d9b90a68d92b267f7ec";
          sha256 = "sha256-YUogcLO+W1hD0X/nsworGS1SHsOolp/g9N0rQJ/Q5wc=";
        };
        file = "/Nord.tmTheme";
      };

      kanagawa = {
        src = pkgs.fetchFromGitHub {
          owner = "rebelot";
          repo = "kanagawa.nvim";
          rev = "7b411f9e66c6f4f6bd9771f3e5affdc468bcbbd2";
          sha256 = "sha256-kV+hNZ9tgC8bQi4pbVWRcNyQib0+seQrrFnsg7UMdBE=";
        };
        file = "/extras/kanagawa.tmTheme";
      };
    };
  };
}
