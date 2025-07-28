{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    settings.ensure_installed = "all";
    settings.ignore_install = [ "norg" ];
    settings.highlight.enable = true;
    settings.highlight.disable = [ ];
    settings.incremental_selection.enable = true;
    settings.indent.enable = true;
    nixvimInjections = true;
  };
  programs.nixvim.plugins.treesitter-context.enable = true;
}
