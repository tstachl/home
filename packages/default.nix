{ pkgs ? (import <nixpkgs>) { } }: {
  hello = pkgs.callPackage ./hello.nix { };
  photo-cli = pkgs.callPackage ./photo-cli.nix { };
  tmux-select-pane-no-wrap = pkgs.callPackage ./tmux-select-pane-no-wrap.nix { };
  tmux-sessionizer = pkgs.callPackage ./tmux-sessionizer.nix { };
  aerospace-tmux-focus = pkgs.callPackage ./aerospace-tmux-focus.nix { };
}
