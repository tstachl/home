{
  git-hooks.hooks = {
    deadnix.enable = true;
    nixpkgs-fmt.enable = true;
  };

  scripts.update.exec = "nix flake update";
  scripts.home-manager.exec = "nix run github:nix-community/home-manager --";
  scripts.hmb.exec = "home-manager build --flake .#(whoami)@(hostname)";
  scripts.hms.exec = "home-manager switch --flake .#(whoami)@(hostname)";
  scripts.drb.exec = "darwin-rebuild build --flake .#(hostname)";
  scripts.drs.exec = "darwin-rebuild switch --flake .#(hostname)";
  scripts.nrb.exec = "nixos-rebuild build --flake .#(hostname)";
  scripts.nrs.exec = "nixos-rebuild switch --flake .#(hostname)";
}
