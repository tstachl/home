{
  "..." = "cd ../..";
  "...." = "cd ../../..";

  # Git stuff
  g = "git";
  gco = "git checkout ";
  gcob = "git checkout -b ";
  ghic = "gh issue create --body '' ";

  # nix stuff
  hmb = "nix run github:nix-community/home-manager -- build";
  hms = "nix run github:nix-community/home-manager -- switch";

  home-manager = "nix run github:nix-community/home-manager --";

  drb = "nix run github:lnl7/nix-darwin -- build";
  drs = "nix run github:lnl7/nix-darwin -- switch";

  nrb = "nix run github:nixos/nixpkgs -- build";
  nrs = "nix run github:nixos/nixpkgs -- switch";
}
