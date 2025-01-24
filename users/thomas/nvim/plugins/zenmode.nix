{
  keymaps = [
    { key = "<leader>z"; action = "<cmd>ZenMode<CR>"; options.desc = "[Z]en Mode"; }
  ];

  plugins.zen-mode = {
    enable = true;
    settings = {
      plugins.alacritty.enabled = true;
      plugins.tmux.enabled = true;
      window.width = 0.5;
    };
  };
}
