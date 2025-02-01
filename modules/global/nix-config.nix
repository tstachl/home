{
  lib,
  pkgs,
  config,
  outputs,
  ...
}:
{
  nix = {
    package = pkgs.nix;

    settings = {
      substituters = [
        "https://cache.nixos.org"
        "https://cachix.cachix.org"
        "https://devenv.cachix.org"
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      trusted-users = [
        "root"
        "@wheel"
        "@admin"
      ];
    };

    extraOptions =
      ''
        warn-dirty = false
        experimental-features = nix-command flakes impure-derivations
        auto-optimise-store = true
      ''
      + lib.optionalString (pkgs.system == "aarch64-darwin") ''
        extra-platforms = x86_64-darwin aarch64-darwin x86_64-linux aarch64-linux
      '';

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };

    # Map registries to channels
    # Very useful when using legacy commands
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    # TODO: Conditionally add the optimise attribute if it exists
    # } // lib.mkIf (lib.hasAttr "nix.optimise.automatic" config) {
    #   optimise = {
    #     automatic = lib.mkDefault true;
    #   };
  };

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];

    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
  };
}
