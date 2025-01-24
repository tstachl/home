{
  keymaps = [
    # clear search highlight on <ESC>
    { key = "<Esc>"; action = "<cmd>nohlsearch<CR>"; mode = "n"; }
    # Diagnostic keymaps
    # { key = "<leader>q"; action.__raw = "vim.diagnostic.setloclist"; mode = "n"; options.desc = "Open diagnostic [Q]uickfix list"; }
    # Exit terminal mode in the builtin terminal
    # { key = "<Esc><Esc>"; action = "<C-\\><C-n>"; mode = "t"; option.desc = "Exit terminal mode"; }
    # Keybinds to make split navigation easier.
    { key = "<C-h>"; action = "<C-w><C-h>"; mode = "n"; options.desc = "Move focus to the left window"; }
    { key = "<C-l>"; action = "<C-w><C-l>"; mode = "n"; options.desc = "Move focus to the right window"; }
    { key = "<C-j>"; action = "<C-w><C-j>"; mode = "n"; options.desc = "Move focus to the lower window"; }
    { key = "<C-k>"; action = "<C-w><C-k>"; mode = "n"; options.desc = "Move focus to the upper window"; }
    # Move highlighed blocks of code up and down
    { key = "K"; action = ":m '<-2<CR>gv=gv"; mode = "v"; }
    { key = "J"; action = ":m '>+1<CR>gv=gv"; mode = "v"; }

    { key = "J"; action = "mzJ`z"; mode = "n"; }
    { key = "<C-d>"; action = "<C-d>zz"; mode = "n"; }
    { key = "<C-u>"; action = "<C-u>zz"; mode = "n"; }
    { key = "n"; action = "nzzzv"; mode = "n"; }
    { key = "N"; action = "Nzzzv"; mode = "n"; }
  ];
}
