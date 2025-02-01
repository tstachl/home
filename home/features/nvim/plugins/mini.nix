{
  plugins.web-devicons.enable = true;
  plugins.mini.enable = true;
  plugins.mini.modules = {
    ai.n_lines = 500;
    surround = { };
    statusline.section_location.__raw = ''
      function()
        return '%2l:%-2v'
      end
    '';
  };
}
