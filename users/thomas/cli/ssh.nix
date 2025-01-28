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
        remoteForwards = [
          {
            host.address = "/Users/thomas/.config/gnupg/S.gpg-agent.extra";
            bind.address = "/run/user/1000/gnupg/d.o6jzqfigwppq1eps4nhng6n5/S.gpg-agent";
          }
          {
            host.address = "/Users/thomas/.config/gnupg/S.gpg-agent.ssh";
            bind.address = "/run/user/1000/gnupg/d.o6jzqfigwppq1eps4nhng6n5/S.gpg-agent.ssh";
          }
        ];
      };

      "github.com".user = "git";
      github.hostname = "github.com";
    };
  };
}
