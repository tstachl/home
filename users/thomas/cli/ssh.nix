{ config, ... }:
let
  inherit (config.xdg) configHome;
in
{
  home.sessionVariables = {
    SSH_AUTH_SOCK = "${configHome}/gnupg/S.gpg-agent.ssh";
  };

  programs.ssh = {
    enable = true;
    compression = true;
    forwardAgent = true;

    extraConfig = ''
      StreamLocalBindUnlink yes
    '';

    matchBlocks = {
      modgud = {
        hostname = "modgud.t5.st";
        user = "thomas";
      };

      "github.com".user = "git";
      github.hostname = "github.com";
    };
  };
}
