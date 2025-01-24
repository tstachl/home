{ pkgs, ... }:
{
  plugins.treesitter = {
    grammarPackages =
      pkgs.stable.vimPlugins.nvim-treesitter.passthru.allGrammars;

    enable = true;
    settings.ensure_installed = "all";
    settings.ignore_install = [ "norg" ];
    settings.highlight.enable = true;
    settings.highlight.disable = [ "go" ];
    settings.incremental_selection.enable = true;
    settings.indent.enable = true;
    nixvimInjections = true;
  };
  plugins.treesitter-context.enable = true;
}
