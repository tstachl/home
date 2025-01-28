{ pkgs, lib, ... }:
let
  homeLocation = with pkgs.stdenv.hostPlatform;
    if isDarwin then "/Users" else "/home";
in
{
  imports = [
    ../fish.nix
  ];

  environment.shells = [ pkgs.fish ];

  users.users.thomas = {
    home = lib.mkDefault "${homeLocation}/thomas";
    shell = pkgs.fish;
  };
}
