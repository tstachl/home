{
  plugins.lint.enable = true;
  plugins.lint.lintersByFt = {
    elixir = [ "credo" ];
  };
}

      # vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      #   group = lint_augroup,
      #   callback = function()
      #     lint.try_lint()
      #   end,
      # })
