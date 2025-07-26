{ config, ... }:
{
  programs.password-store.enable = true;

  programs.fish.shellInit = ''
    set PASSWORD_STORE_DIR "${config.xdg.dataHome}/password-store";
    set PASSWORD_STORE_KEY "7A53D4C6B481F7711588D34FDE749C31D060A160";
    set PASSWORD_STORE_SIGNING_KEY "7A53D4C6B481F7711588D34FDE749C31D060A160";
  '';
}
