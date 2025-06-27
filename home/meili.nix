{
  imports = [
    ./features/core.nix

    ./features/cli
    ./features/desktop
    ./features/nvim

    # ./features/mail.nix
  ];

  programs.fish.interactiveShellInit = ''
    eval "$(/opt/homebrew/bin/brew shellenv)"
  '';
}
