{ pkgs, ... }:
{
  home.packages = with pkgs; [
    aider-chat
  ];

  home.sessionVariables = {
    OPENROUTER_API_KEY = "";
  };

  # programs.fish.interactiveShellInit = ''
  #   set OPENROUTER_API_KEY $(pass openrouter.ai/avante)
  # '';
}
