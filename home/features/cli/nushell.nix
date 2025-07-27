{ config, ... }: {
  home.sessionVariables.SHELL = "${config.programs.nushell.package}/bin/nu";
  programs.nushell = {
    enable = true;
    shellAliases = import ./shell-aliases.nix;
  };
}
