{ pkgs
, config
, lib
, ...
}:
let
  kanagawaSrc = pkgs.fetchFromGitHub {
    owner = "rebelot";
    repo = "kanagawa.nvim";
    rev = "master";
    sha256 = "sha256-i54hTf4AEFTiJb+j5llC5+Xvepj43DiNJSq0vPZCIAg=";
  };

  tmux-sessionizer = lib.getExe config.programs.tmux.sessionizer.package;
in
{
  xdg.configFile = {
    "ghostty/themes/kanagawa-dragon".text =
      lib.strings.fileContents
        (kanagawaSrc + "/extras/ghostty/kanagawa-dragon");

    "ghostty/themes/kanagawa-lotus".text =
      lib.strings.fileContents
        (kanagawaSrc + "/extras/ghostty/kanagawa-lotus");

    "ghostty/themes/kanagawa-wave".text =
      lib.strings.fileContents
        (kanagawaSrc + "/extras/ghostty/kanagawa-wave");
  };

  programs.ghostty = {
    enable = true;
    # Ghostty is a terminal emulator for macOS, it is not available in Nixpkgs
    # TODO: https://github.com/NixOS/nixpkgs/blob/76efb9f313b326ed24dfae33ff0496a6df370e5a/pkgs/by-name/gh/ghostty/package.nix#L192
    package = null; # installed via brew cask

    installBatSyntax = false;
    installVimSyntax = false;

    enableFishIntegration = true;

    settings = {
      command = "${lib.getExe config.programs.fish.package}";

      background-opacity = 0.9;
      font-family = "FiraCode Nerd Font";
      font-size = 16.0;

      macos-titlebar-style = "hidden";
      theme = "kanagawa-dragon";

      window-padding-balance = true;
      window-padding-color = "extend";
      window-padding-x = 10;
      window-padding-y = "10,0";
      window-theme = "ghostty";

      keybind = [
        "ctrl+f=text:\"${tmux-sessionizer}\n\""
        "alt+h=text:\"${tmux-sessionizer} -s 0\n\""
        "alt+t=text:\"${tmux-sessionizer} -s 1\n\""
        "alt+n=text:\"${tmux-sessionizer} -s 2\n\""
        "alt+s=text:\"${tmux-sessionizer} -s 3\n\""
      ];
    };
  };
}
