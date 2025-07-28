{ config
, lib
, ...
}:
with lib; let
  cfg = config.networking;

  remoteLogin = optionalString (cfg.remote-login) ''
    systemsetup -setremotelogin on
  '';
in
{
  options = {
    networking.remote-login = mkEnableOption "remote login";
  };

  config = {
    system.activationScripts.networking.text = mkIf cfg.remote-login (mkAfter ''
      # enable remote login
      echo "enabling remote login..." >&2

      ${remoteLogin}
    '');
  };
}
