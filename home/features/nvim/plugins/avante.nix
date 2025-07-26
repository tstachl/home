{
  plugins.avante.enable = true;
  plugins.avante.settings = {
    hints.enabled = false;
    provider = "openrouter";
    vendors.openrouter = {
      __inherited_from = "openai";
      endpoint = "https://openrouter.ai/api/v1";
      api_key_name = "OPENROUTER_API_KEY";
      model = "moonshotai/kimi-k2:free";
    };
  };
}
