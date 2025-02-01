{
  plugins.snacks = {
    enable = true;
    autoLoad = true;
    settings = {
      bigfile = {
        enabled = true;
      };
      dashboard = {
        width = 60;
        row = null;
        col = null;
        pane_gap = 4;
        autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

        sections = [
          { section = "header"; }
          {
            section = "keys";
            gap = 1;
          }
          {
            icon = " ";
            title = "Recent Files";
            section = "recent_files";
            indent = 2;
            padding = [
              2
              2
            ];
          }
          {
            icon = " ";
            title = "Projects";
            section = "projects";
            indent = 2;
            padding = 2;
          }
          { section = "startup"; }
        ];
      };
      notifier = {
        enabled = true;
        timeout = 3000;
      };
      quickfile = {
        enabled = true;
      };
      statuscolumn = {
        enabled = true;
      };
      words = {
        debounce = 100;
        enabled = true;
      };
    };
  };
}
