{ pkgs, ... }:

let
  shell-pkg = pkgs.writeShellScriptBin "shell" ''
    case "$STARSHIP_SHELL" in
      fish) echo 🐟 ;;
      nu) echo 🚀 ;;
      zsh) echo 🐚 ;;
      bash) echo 🐻 ;;
      *) echo "" ;;
    esac
  '';
in

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableTransience = true;

    settings = {
      character.success_symbol = "[➜](bold green)";
      character.error_symbol = "[✗](bold red)";

      shell = {
        disabled = false;
        fish_indicator = "🐟";
        nu_indicator = "☘️";
        bash_indicator = "🐻";
        zsh_indicator = "🐚";
      };

      # custom.shell = {
      #   command = "${pkgs.lib.meta.getExe shell-pkg}";
      #   format = "$all$shell$character";
      #   when = "true";
      # };

      palettes.catppuccin_frappe = {
        rosewater = "#f2d5cf";
        flamingo = "#eebebe";
        pink = "#f4b8e4";
        mauve = "#ca9ee6";
        red = "#e78284";
        maroon = "#ea999c";
        peach = "#ef9f76";
        yellow = "#e5c890";
        green = "#a6d189";
        teal = "#81c8be";
        sky = "#99d1db";
        sapphire = "#85c1dc";
        blue = "#8caaee";
        lavender = "#babbf1";
        text = "#c6d0f5";
        subtext1 = "#b5bfe2";
        subtext0 = "#a5adce";
        overlay2 = "#949cbb";
        overlay1 = "#838ba7";
        overlay0 = "#737994";
        surface2 = "#626880";
        surface1 = "#51576d";
        surface0 = "#414559";
        base = "#303446";
        mantle = "#292c3c";
        crust = "#232634";
      };

      palette = "catppuccin_frappe";
    };
  };
}
