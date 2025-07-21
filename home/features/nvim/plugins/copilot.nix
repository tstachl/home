{
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
      key = "<S-Tab>";
      action.__raw = ''
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", false)
        end
      '';
      mode = "i";
      options.silent = true;
    }
  ];
}
