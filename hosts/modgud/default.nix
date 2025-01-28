{ outputs, ... }:
{
  imports = [
    ./hardware.nix

    outputs.modules.global.gnupg
    outputs.modules.global.locale
    outputs.modules.global.fish
    outputs.modules.global.nix-config
    outputs.modules.global.openssh

    outputs.modules.global.users.thomas

    # ../common/users/thomas
    # ../common/users/thomas/authorized_keys.nix
    # ../common/users/thomas/groups.nix
    # ../common/users/thomas/nixos.nix
  ];

  security.sudo.extraConfig = ''
    # rollback results in sudo lectures after each reboot
    Defaults lecture = never
  '';

  documentation.enable = false;
  documentation.man.enable = false;

  networking.hostName = "modgud";
  time.timeZone = "Europe/Amsterdam";
  system.stateVersion = "25.05";
}
