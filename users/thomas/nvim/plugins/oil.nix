{
  keymaps = [
    { key = "-"; action = "<cmd>Oil<cr>"; mode = "n"; }
  ];

  plugins.oil.enable = true;
  plugins.oil.settings.keymaps = {
    "-" = "<cmd>Oil<cr>";
  };
}
