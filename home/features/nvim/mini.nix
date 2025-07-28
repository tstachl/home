{
  programs.nixvim = {
    plugins.mini.enable = true;
    plugins.mini.mockDevIcons = true;
    plugins.mini.modules = {
      comment = { };
      diff = { };
      icons = { };
      indentscope = { };
      notify = { };
      statusline = { };

      starter = {
        content_hooks = {
          "__unkeyed-1.adding_bullet" = {
            __raw = "require('mini.starter').gen_hook.adding_bullet()";
          };
          "__unkeyed-2.indexing" = {
            __raw = "require('mini.starter').gen_hook.indexing('all', { 'Builtin actions' })";
          };
          "__unkeyed-3.padding" = {
            __raw = "require('mini.starter').gen_hook.aligning('center', 'center')";
          };
        };
        evaluate_single = true;
        header = ''




                                    ░████ ░██                                              
                                   ░██                                                     
          ░█████████  ░███████  ░████████ ░██ ░███████       ░███████  ░██░████  ░████████ 
               ░███  ░██    ░██    ░██    ░██░██    ░██     ░██    ░██ ░███     ░██    ░██ 
             ░███    ░██    ░██    ░██    ░██░█████████     ░██    ░██ ░██      ░██    ░██ 
           ░███      ░██    ░██    ░██    ░██░██            ░██    ░██ ░██      ░██   ░███ 
          ░█████████  ░███████     ░██    ░██ ░███████  ░██  ░███████  ░██       ░█████░██ 
                                                                                       ░██ 
                                                                                 ░███████  
                                                                                           



        '';
        items = {
          "__unkeyed-1.buildtin_actions" = {
            __raw = "require('mini.starter').sections.builtin_actions()";
          };
          "__unkeyed-2.recent_files_current_directory" = {
            __raw = "require('mini.starter').sections.recent_files(10, false)";
          };
          "__unkeyed-3.recent_files" = {
            __raw = "require('mini.starter').sections.recent_files(10, true)";
          };
        };
      };

      surround = {
        mappings = {
          add = "gsa";
          delete = "gsd";
          find = "gsf";
          find_left = "gsF";
          highlight = "gsh";
          replace = "gsr";
          update_n_lines = "gsn";
        };
      };
    };
  };
}
