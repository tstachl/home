{
  description = "my nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05?shallow=true";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin?shallow=true";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable?shallow=true";

    darwin.url = "github:lnl7/nix-darwin/nix-darwin-25.05?shallow=true";
    darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";

    devenv.url = "github:cachix/devenv?shallow=true";
    devenv.inputs.nixpkgs.follows = "nixpkgs-unstable";

    disko.url = "github:nix-community/disko?shallow=true";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/master?shallow=true";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim/nixos-25.05?shallow=true";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,

      nixpkgs,
      nixpkgs-darwin,
      nixpkgs-unstable,

      devenv,
      disko,
      home-manager,
      nixvim,

      ...
    }@inputs:
    rec {

      lib = import ./lib {
        inherit inputs;
        inherit (self) outputs;
      };

      homeConfigurations = {
        "thomas@meili" = lib.mkHome {
          system = "aarch64-darwin";
          modules = [ ./home/meili.nix ];
        };

        "thomas@modgud" = lib.mkHome {
          system = "x86_64-linux";
          modules = [ ./home/modgud.nix ];
        };
      };

      nixosConfigurations = {
        modgud = lib.mkSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/modgud ];
        };

        odin = lib.mkSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/odin ];
        };
      };

      darwinConfigurations = {
        meili = lib.mkDarwin {
          system = "aarch64-darwin";
          modules = [ ./hosts/meili ];
        };
      };

      modules = import ./modules;
      overlays = import ./overlays { inherit inputs; };

      packages = lib.eachSystemWithPkgs (import ./packages);
      codecov-cli = inputs.nixpkgs-unstable.legacyPackages.aarch64-darwin.codecov-cli;
      formatter = lib.eachSystem (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
    };
}
