{
  programs.nixvim = {
    plugins.copilot-lua.enable = true;
    plugins.copilot-lua.settings = {
      suggestion = {
        enabled = true;
        auto_trigger = true;
        accept = false;
      };
      panel.enabled = false;
      filetypes."*" = true;
    };

    keymaps = [
      {
        key = "<C-f>";
        action.__raw = ''
          function()
            if require("copilot.suggestion").is_visible() then
              require("copilot.suggestion").accept()
            else
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-f>", true, false, true), "n", false)
            end
          end
        '';
        mode = "i";
        options.silent = true;
      }
    ];
  };
}
