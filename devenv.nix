{ pkgs, lib, ... }:
{
  git-hooks.hooks = {
    deadnix.enable = true;
    nixpkgs-fmt.enable = true;
  };

  scripts = rec {
    update.exec = "nix flake update";
    home-manager.exec = "${lib.getExe pkgs.home-manager} $@";
    nixos-rebuild.exec = "${lib.getExe pkgs.nixos-rebuild} $@";

    hmb.exec = ''
      ${home-manager.exec} build --flake .#$(whoami)@$(hostname);
    '';
    hms.exec = ''
      ${home-manager.exec} switch --flake .#$(whoami)@$(hostname);
      zen --ProfileManager
    '';

    nrb.exec = ''
      ${nixos-rebuild.exec} build --flake .#$(hostname);
    '';
    nrs.exec = ''
      ${nixos-rebuild.exec} switch --flake .#$(hostname);
    '';

    drb.exec = ''
      sudo darwin-rebuild build --flake .#$(hostname);
    '';
    drs.exec = ''
      sudo darwin-rebuild switch --flake .#$(hostname);
    '';
  };
}
