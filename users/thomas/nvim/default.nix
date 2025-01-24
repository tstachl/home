{ inputs, lib, ... }:
let
  # Define `recursiveUpdateMany` if not present
  recursiveUpdateMany = sets: lib.fold lib.attrsets.recursiveUpdate {} sets;

  # Merge all plugin configurations directly from imports
  nixvim = recursiveUpdateMany [
    (import ./colorschemes.nix)
    (import ./keymaps.nix)
    (import ./options.nix)
    (import ./plugins.nix)
  ];
in
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = nixvim;
}
