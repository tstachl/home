{ inputs
, pkgs
, ...
}:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./copilot.nix # copilot plugin
    ./lsp.nix
    ./mini.nix # mini.nvim plugin
    ./telescope.nix # fuzzy find everything
    ./treesitter.nix # treesitter support
    ./which-key.nix # keybinding helper
  ];

  programs.nixvim.plugins = {
    tmux-navigator.enable = true; # tmux navigation
    todo-comments.enable = true; # todo comments eg TODO, FIXME, etc
  };

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;

    extraPlugins = with pkgs; [
      vimPlugins.kanagawa-nvim
    ];

    extraConfigLua = ''
      require("kanagawa").setup({
        transparent = true,
      })
      vim.cmd.colorscheme("kanagawa")
    '';

    globals.mapleader = " ";
    globals.maplocalleader = " ";
    globals.have_nerd_font = true;

    clipboard.register = "unnamedplus";

    opts = {
      number = true;
      relativenumber = true;
      showmode = false;
      breakindent = true;
      undofile = true;
      ignorecase = true;
      smartcase = true;
      signcolumn = "yes";
      updatetime = 250;
      timeoutlen = 300;
      splitright = true;
      splitbelow = true;
      list = true;
      listchars = {
        tab = "» ";
        trail = "·";
        nbsp = "␣";
      };
      inccommand = "split";
      cursorline = true;
      scrolloff = 10;
      hlsearch = true;
      swapfile = false;
      backup = false;
      conceallevel = 1;
      laststatus = 3;
      cmdheight = 0;
    };

    autoCmd = [
      {
        event = "TextYankPost";
        desc = "Highlight when yanking (copying) text";
        group = "kickstart-highlight-yank";
        callback.__raw = ''
          function()
            vim.highlight.on_yank()
          end
        '';
      }
    ];

    autoGroups = {
      "kickstart-highlight-yank".clear = true;
    };

    keymaps = [
      { key = "<Esc>"; action = "<cmd>nohlsearch<CR>"; mode = "n"; }
      # Diagnostic keymaps
      # { key = "<leader>q"; action.__raw = "vim.diagnostic.setloclist"; mode = "n"; options.desc = "Open diagnostic [Q]uickfix list"; }
      # Exit terminal mode in the builtin terminal
      # { key = "<Esc><Esc>"; action = "<C-\\><C-n>"; mode = "t"; option.desc = "Exit terminal mode"; }
      # Keybinds to make split navigation easier. TODO: figure out if these work
      { key = "<C-h>"; action = "<C-w><C-h>"; mode = "n"; options.desc = "Move focus to the left window"; }
      { key = "<C-l>"; action = "<C-w><C-l>"; mode = "n"; options.desc = "Move focus to the right window"; }
      { key = "<C-j>"; action = "<C-w><C-j>"; mode = "n"; options.desc = "Move focus to the lower window"; }
      { key = "<C-k>"; action = "<C-w><C-k>"; mode = "n"; options.desc = "Move focus to the upper window"; }
      # Move highlighed blocks of code up and down
      { key = "K"; action = ":m '<-2<CR>gv=gv"; mode = "v"; options.desc = "Move highlighted block up"; }
      { key = "J"; action = ":m '>+1<CR>gv=gv"; mode = "v"; options.desc = "Move highlighted block down"; }

      { key = "J"; action = "mzJ`z"; mode = "n"; options.desc = "Join lines without losing cursor position"; }

      { key = "<C-d>"; action = "<C-d>zz"; mode = "n"; options.desc = "Scroll down and center cursor"; }
      { key = "<C-u>"; action = "<C-u>zz"; mode = "n"; options.desc = "Scroll up and center cursor"; }

      { key = "n"; action = "nzzzv"; mode = "n"; options.desc = "Find next and center cursor"; }
      { key = "N"; action = "Nzzzv"; mode = "n"; options.desc = "Find previous and center cursor"; }
    ];
  };
}
