{
  keymaps = [
    {
      key = "<leader>f";
      action.__raw = ''
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end
      '';
      options.desc = "[F]ormat buffer";
    }
  ];

  plugins.conform-nvim = {
    enable = true;
    settings.formatters_by_ft = {
      lua = [ "lua_ls" ];
      javascript = [ [ "prettierd" "prettier" ] [ "eslint_d" "eslint" ] ];
      typescript = [ [ "prettierd" "prettier" ] [ "eslint_d" "eslint" ] ];
    };
    settings.notify_on_error = false;
  };
}
