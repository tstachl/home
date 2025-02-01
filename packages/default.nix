{
  pkgs ? (import <nixpkgs>) { },
}:
{
  # ghostty = pkgs.callPackage ./ghostty/package.nix {};
  hello = pkgs.callPackage ./hello.nix { };
  photo-cli = pkgs.callPackage ./photo-cli.nix { };
}
