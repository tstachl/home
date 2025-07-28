{ config
, lib
, ...
}:
let
  configHome = "${config.xdg.configHome}/gnupg";
in
{
  home.sessionVariables = {
    SSH_AUTH_SOCK = lib.mkDefault "${configHome}/S.gpg-agent.ssh";
  };

  programs.ssh = {
    enable = true;
    compression = true;
    forwardAgent = true;

    extraConfig = ''
      StreamLocalBindUnlink yes
    '';

    matchBlocks = {
      "github.com".user = "git";
      "codeberg.org".user = "git";
      github.hostname = "github.com";
      codeberg.hostname = "codeberg.org";
    };
  };
}
