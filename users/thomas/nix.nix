{ pkgs, lib, ... }:
{
  nix = {
    settings = {
      substituters = [
        "https://cache.nixos.org/"
        "https://devenv.cachix.org"
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      trusted-users = [ "thomas" ];
    };

    package = lib.mkDefault pkgs.nixVersions.stable;

    extraOptions = ''
      warn-dirty = false
      experimental-features = nix-command flakes impure-derivations
    '';
  };
}
