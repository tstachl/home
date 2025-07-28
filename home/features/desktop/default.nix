{
  imports = [
    ./aerospace.nix
    ./fonts.nix
    ./ghostty.nix
    ./yubikey.nix
    ./zen-browser.nix
  ];

  services.syncthing.enable = true;
}
