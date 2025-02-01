{
  config,
  lib,
  pkgs,
  ...
}:
let
  configHome = "${config.xdg.configHome}/gnupg";
in
{
  home.sessionVariables = {
    GNUPGHOME = configHome;
  };

  programs.gpg = {
    enable = true;
    homedir = configHome;

    publicKeys = [
      {
        source = pkgs.fetchurl {
          url = "https://keys.openpgp.org/vks/v1/by-fingerprint/7A53D4C6B481F7711588D34FDE749C31D060A160";
          sha256 = "c4I7c+mZVOJpm54aOhIJQtAXAhBQZPnyp4LHEzuH09w=";
        };
        trust = 5;
      }
    ];
  };

  services.gpg-agent = {
    enable = lib.mkDefault true;
    defaultCacheTtl = 600;
    maxCacheTtl = 7200;
    enableExtraSocket = true;
    enableSshSupport = true;
    extraConfig = ''
      keep-tty
      keep-display
    '';
  };
}
