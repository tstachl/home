{ pkgs, lib, ... }:
{
  git-hooks.hooks = {
    deadnix.enable = true;
    nixpkgs-fmt.enable = true;
  };

  scripts = {
    update.exec = "nix flake update";

    hmb.exec = ''
      ${lib.getExe pkgs.home-manager} build --flake .#$(whoami)@$(hostname);
    '';
    hms.exec = ''
      ${lib.getExe pkgs.home-manager} switch --flake .#$(whoami)@$(hostname);
    '';

    nrb.exec = ''
      ${lib.getExe pkgs.nixos-rebuild} build --flake .#$(hostname);
    '';
    nrs.exec = ''
      ${lib.getExe pkgs.nixos-rebuild} switch --flake .#$(hostname);
    '';

    drb.exec = ''
      sudo darwin-rebuild build --flake .#$(hostname);
    '';
    drs.exec = ''
      sudo darwin-rebuild switch --flake .#$(hostname);
    '';
  };
}
