{
  plugins.which-key.enable = true;
  plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>c";
      group = "[C]ode";
      icon = "󰄄 ";
    }
    {
      __unkeyed-1 = "<leader>d";
      group = "[D]ocuments";
      icon = "󰄄 ";
    }
    {
      __unkeyed-1 = "<leader>r";
      group = "[R]ename";
      icon = "󰄄 ";
    }
    {
      __unkeyed-1 = "<leader>s";
      group = "[S]earch";
      icon = "󰄄 ";
    }
    {
      __unkeyed-1 = "<leader>w";
      group = "[W]orkspace";
      icon = "󰄄 ";
    }
    {
      __unkeyed-1 = "<leader>t";
      group = "[T]oggle";
      icon = "󰄄 ";
    }
    {
      __unkeyed-1 = "<leader>h";
      group = "Git [H]unk";
      icon = "󰄄 ";
      mode = [ "n" "v" ];
    }
  ];
  # { '<leader>c', group = '[C]ode' },
  # { '<leader>d', group = '[D]ocument' },
  # { '<leader>r', group = '[R]ename' },
  # { '<leader>s', group = '[S]earch' },
  # { '<leader>w', group = '[W]orkspace' },
  # { '<leader>t', group = '[T]oggle' },
  # { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }
}
