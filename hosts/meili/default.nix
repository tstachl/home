{ outputs, ... }:
{
  imports = [
    outputs.modules.global.nix-config

    ./colima.nix

    ./system.nix
    ./software.nix
  ] ++ (builtins.attrValues outputs.modules.darwin);

  # NOTE: this seems to be needed to make nix work in fish
  programs.fish = {
    enable = true;
    vendor = {
      completions.enable = true;
      config.enable = true;
      functions.enable = true;
    };
  };

  # TODO: move into module:
  # system.activationScripts.extraActivation.text = lib.mkAfter ''
  #   # disable spotlight
  #   echo "disable spotlight..." >&2
  #   mdutil -i off /
  # '';

  # TODO:
  #   - Proton Mail Bridge
  #   - Proton Drive set up home folders

  programs = {
    nix-index.enable = true;
    gnupg.agent.enable = true;
  };

  services.nix-daemon.enable = true;

  users.users.thomas.home = "/Users/thomas";

  networking = {
    hostName = "meili";
    remote-login = true;
  };

  time.timeZone = "America/Los_Angeles";
  system.stateVersion = 4;
}
