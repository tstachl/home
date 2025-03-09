{ inputs, lib, pkgs, ... }:
let
  # Define `recursiveUpdateMany` if not present
  recursiveUpdateMany = sets: lib.fold lib.attrsets.recursiveUpdate { } sets;

  # Merge all plugin configurations directly from imports
  nixvim = recursiveUpdateMany [
    ({
      enable = true;
      defaultEditor = true;
      vimdiffAlias = true;

      extraPlugins = with pkgs; [
        (vimUtils.buildVimPlugin rec {
          pname = "nord.nvim";
          version = "1.1.0";
          src = fetchFromGitHub {
            owner = "gbprod";
            repo = "nord.nvim";
            rev = "v${version}";
            sha256 = "sha256-gSAXDXhxoigWl6qMAJ0yX59bnkOehVA1MADMeHoTHDo=";
          };
          meta.homepage = "https://github.com/gbprod/nord.nvim";
        })
        vimPlugins.vim-tmux-focus-events
      ];

      extraConfigLua = ''
        require("nord").setup({
          transparent = true,
        })
        vim.cmd.colorscheme("nord")
      '';
    })

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
