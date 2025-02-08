{
  pkgs ? (import <nixpkgs>) { },
}:
{
  # ghostty = pkgs.callPackage ./ghostty/package.nix {};
  hello = pkgs.callPackage ./hello.nix { };
  photo-cli = pkgs.callPackage ./photo-cli.nix { };
  zen-browser = pkgs.callPackage ./zen-browser { };
  more-tmux-plugins = pkgs.callPackage ./more-tmux-plugins.nix { };
}
