{ pkgs, lib, config, outputs, ... }:
let
  homeLocation = with pkgs.stdenv.hostPlatform;
    if isDarwin then "/Users" else "/home";
in
{
  imports = [
    outputs.modules.global.nix-config

    ./cli
  ];

  manual.manpages.enable = false;
  xdg.enable = true;

  home = {
    username = lib.mkDefault "thomas";
    homeDirectory = lib.mkDefault "${homeLocation}/${config.home.username}";
    sessionVariables = {
      SHELL = "${pkgs.nushell}/bin/nu";
    };
    stateVersion = lib.mkDefault "24.11";
  };
}
