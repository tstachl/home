{
  plugins.cmp.enable = true;
  plugins.cmp.autoEnableSources = true;
  plugins.cmp.settings.mapping = {
    "<C-n>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
    "<C-p>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
    "<C-b>" = "cmp.mapping.scroll_docs(-4)";
    "<C-f>" = "cmp.mapping.scroll_docs(4)";
    "<C-y>" = "cmp.mapping.confirm({ select = true })";
    "<C-Space>" = "cmp.mapping.complete()";
    "<C-e>" = "cmp.mapping.close()";

    "<C-l>" = ''
      cmp.mapping(function()
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { 'i', 's' })
    '';

    "<C-h>" = ''
      cmp.mapping(function()
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { 'i', 's' })
    '';
  };
  plugins.cmp.settings.sources = [
    { name = "nvim_lsp"; }
    { name = "luasnip"; }
    { name = "path"; }
    { name = "buffer"; }
    { name = "friendly-snippets"; }
  ];

  plugins.luasnip.enable = true;
  plugins.cmp_luasnip.enable = true;
  plugins.cmp-nvim-lsp.enable = true;
  plugins.cmp-nvim-lsp-document-symbol.enable = true;
  plugins.cmp-nvim-lsp-signature-help.enable = true;
  plugins.cmp-path.enable = true;
  plugins.friendly-snippets.enable = true;
}
