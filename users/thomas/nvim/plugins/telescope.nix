{
  plugins.telescope = {
    enable = true;
    settings.pickers.find_files.follow = true;
    extensions.fzf-native.enable = true;
    extensions.ui-select.enable = true;
  };

  keymaps = [
    { mode = "n"; key = "<leader>sh"; action.__raw = "require('telescope.builtin').help_tags"; options.desc = "[S]earch [H]elp"; }
    { mode = "n"; key = "<leader>sk"; action.__raw = "require('telescope.builtin').keymaps"; options.desc = "[S]earch [K]eymaps"; }
    { mode = "n"; key = "<leader>sf"; action.__raw = "require('telescope.builtin').find_files"; options.desc = "[S]earch [F]iles"; }
    { mode = "n"; key = "<leader>ss"; action.__raw = "require('telescope.builtin').builtin"; options.desc = "[S]earch [S]elect Telescope"; }
    { mode = "n"; key = "<leader>sw"; action.__raw = "require('telescope.builtin').grep_string"; options.desc = "[S]earch current [W]ord"; }
    { mode = "n"; key = "<leader>sg"; action.__raw = "require('telescope.builtin').live_grep"; options.desc = "[S]earch by [G]rep"; }
    { mode = "n"; key = "<leader>s."; action.__raw = "require('telescope.builtin').oldfiles"; options.desc = "[S]earch Recent Files (\".\" for repeat)"; }
    { mode = "n"; key = "<leader>sd"; action.__raw = "require('telescope.builtin').diagnostics"; options.desc = "[S]earch [D]iagnostics"; }
    { mode = "n"; key = "<leader>sr"; action.__raw = "require('telescope.builtin').resume"; options.desc = "[S]earch [R]esume"; }
    { mode = "n"; key = "<leader><leader>"; action.__raw = "require('telescope.builtin').buffers"; options.desc = "[ ] Find existing buffers"; }

    {
      mode = "n";
      key = "<leader>/";
      action.__raw = ''
        function()
          require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end
      '';
      options.desc = "[/] Fuzzily search in current buffer";
    }

    {
      mode = "n";
      key = "<leader>s/";
      action.__raw = ''
        function()
          require('telescope.builtin').live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end
      '';
      options.desc = "[S]earch [/] in Open Files";
    }

    {
      mode = "n";
      key = "<leader>sn";
      action.__raw = ''
        function()
          require('telescope.builtin').find_files {
            cwd = vim.fn.stdpath 'config'
          }
        end
      '';
      options.desc = "[S]earch [N]eovim files";
    }
  ];
}
