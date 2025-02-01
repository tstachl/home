{
  pkgs,
  outputs,
  lib,
  ...
}:
{
  imports = [
    # INFO: this is shared between home-manager, nixos, and darwin
    outputs.modules.global.nix-config
  ];

  xdg.enable = true;

  home = {
    username = "thomas";
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/thomas" else "/home/thomas";

    packages = with pkgs; [
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
