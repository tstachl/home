{ outputs, pkgs, ... }:
{
  imports = [
    outputs.modules.global.nix-config
    ./system.nix
    ./software.nix
  ] ++ (builtins.attrValues outputs.modules.darwin);

  # NOTE: might be valuable to put this in it's own file
  # nix.linux-builder = {
  #   enable = true;
  #   ephemeral = true;
  #   package = pkgs.darwin.linux-builder;
  #   supportedFeatures = [ "kvm" "benchmark" "big-parallel" "nixos-test" ];
  #   maxJobs = 4;
  #   config = {
  #     # nix.settings.sandbox = false;
  #     virtualisation = {
  #       darwin-builder = {
  #         diskSize = 40 * 1024;
  #         memorySize = 8 * 1024;
  #       };
  #       cores = 6;
  #     };
  #   };
  # };
  # nix.settings.system-features = [ "nixos-test" "apple-virt" "nixos-test" "benchmark" "big-parallel" "kvm" ];
  # nix.settings.extra-platforms = [ "aarch64-linux" ];
  # launchd.daemons.linux-builder = {
  #   serviceConfig = {
  #     StandardOutPath = "/var/log/darwin-builder.log";
  #     StandardErrorPath = "/var/log/darwin-builder.log";
  #   };
  # };

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

  users.users.thomas.home = "/Users/thomas";

  networking = {
    hostName = "meili";
    remote-login = true;
  };

  time.timeZone = "America/Los_Angeles";
  system.stateVersion = 4;
}
