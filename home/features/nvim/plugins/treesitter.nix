{ pkgs, ... }:
{
  plugins.treesitter = {
    grammarPackages = pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars;

    enable = true;
    settings.ensure_installed = "all";
    settings.ignore_install = [ "norg" ];
    settings.highlight.enable = true;
    settings.highlight.disable = [  ];
    settings.incremental_selection.enable = true;
    settings.indent.enable = true;
    nixvimInjections = true;
  };
  plugins.treesitter-context.enable = true;
}
