{ pkgs, lib, config, outputs, ... }:
let
  homeLocation = with pkgs.stdenv.hostPlatform;
    if isDarwin then "/Users" else "/home";
in
{
  imports = [
    outputs.homeManagerModules

    ./nix.nix
    ./cli
  ];

  manual.manpages.enable = false;
  xdg.enable = true;

  home = {
    username = lib.mkDefault "thomas";
    homeDirectory = lib.mkDefault "${homeLocation}/${config.home.username}";
    sessionVariables = {
      EDITOR = "${pkgs.neovim}/bin/nvim";
      SHELL = "${pkgs.nushell}/bin/nu";
    };
    stateVersion = lib.mkDefault "24.11";
  };
}
