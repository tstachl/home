{
  cachix = import ./cachix.nix;
  colima = import ./colima.nix;
  devenv = import ./devenv.nix;
  fish = import ./fish.nix;
  fonts = import ./fonts.nix;
  gnupg = import ./gnupg.nix;
  locale = import ./locale.nix;
  nix-config = import ./nix-config.nix;
  openssh = import ./openssh.nix;
  users = import ./users;
}
