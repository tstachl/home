# { pkgs, ... }:
{
  plugins.elixir.enable = false;
  # plugins.elixir.settings = {
  #   nextls = {
  #     enable = true;
  #     cmd = "nextls";
  #     init_options = {
  #       mix_env = "production";
  #       mix_target = "localhost";
  #       experimental.completions.enable = true;
  #       extensions.credo = {
  #         enable = true;
  #         cli_options = [];
  #       };
  #     };
  #     # on_attach.__raw = ''
  #     #   function(client, bufnr)
  #     #     -- from config
  #     #   end
  #     # '';
  #   };
  # #   nextls.enable = true;
  # #   nextls.auto_update = true;
  # #   elixirls.enable = false;
  # #   projectionist.enable = false;
  # };
  # extraPlugins = with pkgs.vimPlugins; [ elixir-tools-nvim ];
  # extraConfigLua = ''
  #   require("elixir").setup()
  # '';
}
