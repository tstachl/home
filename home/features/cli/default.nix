{
  imports = [
    ./aider-chat.nix
    ./bat.nix
    ./direnv.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./gnupg.nix
    ./nostr.nix
    ./pass.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
    ./yazi.nix
    ./zoxide.nix
  ];

  programs.bash.enable = true;
  programs.zsh.enable = true;
}
