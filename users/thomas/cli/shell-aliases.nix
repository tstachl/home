{
  "..." = "cd ../..";
  "...." = "cd ../../..";

  # Git stuff
  g = "git";
  gco = "git checkout ";
  gcob = "git checkout -b ";
  ghic = "gh issue create --body '' ";

  # nix stuff
  hmb = "nix run github:nix-community/home-manager -- build --flake .#(whoami)@(hostname)";
  hms = "nix run github:nix-community/home-manager -- switch --flake .#(whoami)@(hostname)";

  home-manager = "nix run github:nix-community/home-manager --";

  drb = "nix run github:lnl7/nix-darwin -- build --flake .#(hostname)";
  drs = "nix run github:lnl7/nix-darwin -- switch --flake .#(hostname)";

  nrb = "nix run github:nixos/nixpkgs -- build --flake .#(hostname)";
  nrs = "nix run github:nixos/nixpkgs -- switch --flake .#(hostname)";
}
