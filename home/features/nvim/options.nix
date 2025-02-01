{
  globals.mapleader = " ";
  globals.maplocalleader = " ";
  globals.have_nerd_font = true;

  opts = {
    # Make line numbers default
    number = true;
    relativenumber = true;
    # Enable mouse mode, can be useful for resizing splits for example!
    mouse = "a";
    # Don't show the mode, since it's already in the status line
    showmode = false;
    # Enable break indent
    breakindent = true;
    # Save undo history
    undofile = true;
    # Case-insensitive searching UNLESS \C or one or more capital letters in the search term
    ignorecase = true;
    smartcase = true;
    # Keep signcolumn on by default
    signcolumn = "yes";
    # Decrease update time
    updatetime = 250;
    # Decrease mapped sequence wait time
    # Displays which-key popup sooner
    timeoutlen = 300;
    # Configure how new splits should be opened
    splitright = true;
    splitbelow = true;
    # Sets how neovim will display certain whitespace characters in the editor.
    list = true;
    listchars = {
      tab = "» ";
      trail = "·";
      nbsp = "␣";
    };
    # Preview substitutions live, as you type!
    inccommand = "split";
    # Show which line your cursor is on
    cursorline = true;
    # Minimal number of screen lines to keep above and below the cursor.
    scrolloff = 10;
    # Set highlight on search
    hlsearch = true;
    # Disable swapfile and backup
    swapfile = false;
    backup = false;
    # Set's the conceal level
    conceallevel = 1;
    # I don't need a status all the time
    laststatus = 3;
    # Hide command bar
    cmdheight = 0;

    # guicursor = "";
    # incsearch = true;
    # termguicolors = true;
    # scrolloff = 8;
    # isfname = [ "@-@" ];
    # colorcolumn = "80";
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
}
