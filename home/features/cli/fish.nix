{ lib
, pkgs
, ...
}: {
  programs.fish = {
    enable = true;

    interactiveShellInit = lib.mkAfter ''
      fish_config theme choose "Catppuccin Frappe"
    '';
  };

  xdg.configFile."fish/themes/Catppuccin Frappe.theme".text = lib.strings.fileContents (pkgs.fetchFromGitHub
    {
      owner = "catppuccin";
      repo = "fish";
      rev = "cc8e4d8";
      sha256 = "sha256-udiU2TOh0lYL7K7ylbt+BGlSDgCjMpy75vQ98C1kFcc=";
    }
  + "/themes/Catppuccin Frappe.theme");
}
