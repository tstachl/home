{
  git-hooks.hooks = {
    deadnix.enable = true;
    nixpkgs-fmt.enable = true;
  };

  scripts.update.exec = "nix flake update";
}
