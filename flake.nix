{
  description = "my nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    darwin.url = "github:lnl7/nix-darwin/nix-darwin-24.11";
    darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";

    devenv.url = "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim/nixos-24.11";
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
      formatter = lib.eachSystem (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
    };
}
