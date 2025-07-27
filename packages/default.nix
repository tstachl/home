{
  pkgs ? (import <nixpkgs>) { },
}:
{
  hello = pkgs.callPackage ./hello.nix { };
  photo-cli = pkgs.callPackage ./photo-cli.nix { };
  tmuxPlugins = pkgs.tmuxPlugins // {
    tmux-select-pane-no-wrap = pkgs.callPackage ./tmux-select-pane-no-wrap.nix { };
  };
}
