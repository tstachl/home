{
  description = "my home manager configuration";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    devenv.url = "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim/nixos-24.11";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-darwin, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux" "x86_64-linux" "aarch64-darwin" "x86_64-darwin"
      ];
    in
    {


      modules = {
        home-manager = import ./modules/home-manager;
        global = import ./modules/global;
      };

      nixosConfigurations = {
        modgud = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; inherit outputs; };
          modules = [ ./hosts/modgud ];
        };
      };

      packages = forAllSystems (system:
        let
          pkgs = if builtins.elem "darwin" (builtins.split "\\." system) then
              nixpkgs-darwin.legacyPackages.${system}
            else
              nixpkgs.legacyPackages.${system};
        in {
          homeConfigurations = {
            "thomas@meili" = home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              extraSpecialArgs = { inherit inputs; inherit outputs; };
              modules = [
                ./users/thomas
                ./users/thomas/desktop
                ./users/thomas/nvim
              ];
            };

            "thomas@modgud" = home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              extraSpecialArgs = { inherit inputs; inherit outputs; };
              modules = [
                ./users/thomas
                ./users/thomas/modgud
              ];
            };
          };
        }
      );
    };
}
