{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05?shallow=true";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin?shallow=true";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable?shallow=true";

    darwin.url = "github:lnl7/nix-darwin/nix-darwin-25.05?shallow=true";
    darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";

    devenv.url = "github:cachix/devenv?shallow=true";
    devenv.inputs.nixpkgs.follows = "nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/master?shallow=true";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim/nixos-25.05?shallow=true";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, ... }@inputs:
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
        # modgud = lib.mkSystem {
        #   system = "x86_64-linux";
        #   modules = [ ./hosts/modgud ];
        # };

        # odin = lib.mkSystem {
        #   system = "x86_64-linux";
        #   modules = [ ./hosts/odin ];
        # };
      };

      darwinConfigurations = {
        meili = lib.mkDarwin {
          system = "aarch64-darwin";
          modules = [ ./hosts/meili ];
        };
      };

      devShells = lib.mkDevenvShell {
        git-hooks.hooks = {
          deadnix.enable = true;
          nixpkgs-fmt.enable = true;
        };

        scripts.update.exec = "nix flake update";
      };

      modules = import ./modules;
      overlays = import ./overlays { inherit inputs; };

      packages = lib.eachSystem (import ./packages) // lib.eachSystem (system: {
        devenv-up = self.devShells.${system}.default.config.procfileScript;
        devenv-test = self.devShells.${system}.default.config.test;
      });
    };
}
