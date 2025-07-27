{ pkgs
, outputs
, lib
, ...
}: {
  imports = [
    # INFO: this is shared between home-manager, nixos, and darwin
    outputs.modules.global.nix-config
  ];

  xdg.enable = true;

  home = {
    # FIXME: this needs to leave as soon as `ghostty` is merged into 24.11.
    enableNixpkgsReleaseCheck = false;

    username = "thomas";
    homeDirectory =
      if pkgs.stdenv.isDarwin
      then "/Users/thomas"
      else "/home/thomas";

    packages = with pkgs; [
      cachix
      curl
      fd
      ripgrep
      wget
    ];

    sessionVariables = {
      EDITOR = "nvim";
      PAGER = "less";
      VISUAL = "nvim";
    };

    stateVersion = lib.mkDefault "24.11";
  };

  manual.manpages.enable = lib.mkDefault false;
}
