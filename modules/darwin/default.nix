{
  pam-reattach = import ./security/pam-reattach.nix;
  remote-login = import ./networking/remote-login.nix;
  rosetta = import ./system/rosetta.nix;
}
