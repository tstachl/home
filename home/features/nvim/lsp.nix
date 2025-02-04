{
  autoCmd = [
    {
      event = "LspAttach";
      desc = "Keymaps for when LSP is attached";
      group = "kickstart-lsp-attach";
      callback.__raw = ''
        function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end
      '';
    }
  ];

  autoGroups = {
    "kickstart-lsp-attach".clear = true;
  };

  keymaps = [
    {
      key = "<C-h>";
      action.__raw = "vim.lsp.buf.signature_help";
      mode = "i";
    }
  ];

  plugins.lsp = {
    enable = true;

    keymaps = {
      diagnostic = {
        "<leader>vd" = "open_float";
        "[d" = "goto_next";
        "]d" = "goto_prev";
      };

      lspBuf = {
        "<leader>f" = "format";
        "gd" = "definition";
        "K" = "hover";
        "<leader>vws" = "workspace_symbol";
        "<leader>vca" = "code_action";
        "<leader>vrr" = "references";
        "<leader>vrn" = "rename";
      };
    };

    servers = {
      astro.enable = true;
      bashls.enable = true;

      denols = {
        enable = true;
        rootDir = "require('lspconfig').util.root_pattern('deno.json')";
        extraOptions.init_options = {
          lint = true;
          unstable = true;
        };
      };

      gopls.enable = true;

      # elixirls.enable = true;
      nextls.enable = true;
      nil_ls.enable = true;
      tailwindcss.enable = true;

      ts_ls = {
        enable = true;
        extraOptions.single_file_support = false;
        rootDir = ''
          require('lspconfig').util.root_pattern("tsconfig.json")
        '';
      };

      volar.enable = true;
      #   rootDir = ''
      #     # root_pattern = { 'vite.config.ts', 'nuxt.config.ts' },
      #
      #
      #     require('lspconfig').util.root_pattern("vite.config.mts")
      #     '';
      # };
    };
  };
}
