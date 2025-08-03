{ pkgs, ... }:
{
  imports = [
    ./bat.nix
    ./fish.nix
    ./git.nix
    ./gnupg.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
  ];

  home.packages = [
    pkgs.unstable.devenv
    pkgs.unstable.nak
  ];

  programs.bash.enable = true;
  programs.direnv.enable = true;
  programs.fzf.enable = true;
  programs.zoxide.enable = true;
  programs.zsh.enable = true;
}
