{
  imports = [
    ./features/core.nix

    ./features/cli
    ./features/desktop
    ./features/nvim
  ];

  programs.fish.interactiveShellInit = ''
    eval "$(/opt/homebrew/bin/brew shellenv)"
  '';
}
