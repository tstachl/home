{ inputs, outputs }:
let
  # Helper to determine if a system is Darwin
  isDarwin = system: builtins.elem "darwin" (builtins.split "-" system);

  # Helper to get the appropriate nixpkgs for a system
  getPkgsForSystem =
    system:
    if isDarwin system then
      inputs.nixpkgs-darwin.legacyPackages.${system}
    else
      inputs.nixpkgs.legacyPackages.${system};
in
rec {
  mkSystem =
    {
      system,
      nixpkgs ? inputs.nixpkgs,
      modules ? [ ],
    }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system modules nixpkgs;
      specialArgs = { inherit inputs outputs; };
    };

  mkDarwin =
    {
      system,
      modules ? [ ],
    }:
    inputs.darwin.lib.darwinSystem {
      inherit system modules;
      specialArgs = { inherit inputs outputs; };
    };

  mkHome =
    {
      system,
      modules ? [ ],
    }:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit modules;
      pkgs = getPkgsForSystem system;
      extraSpecialArgs = { inherit inputs outputs; };
    };

  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "x86_64-linux"
    "x86_64-darwin"
    "aarch64-linux"
    "aarch64-darwin"
  ];

  forAllSystemsWithPkgs =
    f:
    forAllSystems (
      system:
      f {
        pkgs = getPkgsForSystem system;
      }
    );
}
