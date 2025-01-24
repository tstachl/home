{ pkgs, lib, config, outputs, ... }:
let
  homeLocation = with pkgs.stdenv.hostPlatform;
    if isDarwin then "/Users" else "/home";
in
{
  imports = [
    ./cli
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  nix.package = lib.mkDefault pkgs.nixVersions.stable;
  nix.settings.trusted-users = [ "thomas" ];
  nix.extraOptions = ''
    warn-dirty = false
    experimental-features = nix-command flakes impure-derivations
  '';

  manual.manpages.enable = false;
  xdg.enable = true;

  home = {
    username = lib.mkDefault "thomas";
    homeDirectory = lib.mkDefault "${homeLocation}/${config.home.username}";
    sessionVariables = {
      EDITOR = "${pkgs.neovim}/bin/nvim";
      SHELL = "${pkgs.fish}/bin/fish";
    };
    stateVersion = lib.mkDefault "24.11";
  };
}
