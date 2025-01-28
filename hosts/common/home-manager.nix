{ inputs, outputs, ... }:
let
  home-manager-module =
    if builtins.runCommand "uname" ''{ outFile = "/dev/stdout"; }'' == "Darwin" then
      inputs.home-manager.darwinModules.home-manager
    else
      inputs.home-manager.nixosModules.home-manager;
in
{
  imports = [ home-manager-module ];  
  home-manager = {
    # INFO: since we also use home-manager standalone, we don't want to mix up packages.
    # useGlobalPkgs = true;
    # useUserPackages = true;
    extraSpecialArgs = { inherit inputs; inherit outputs; };
  };
}
