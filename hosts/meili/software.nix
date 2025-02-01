{ pkgs, outputs, ... }:
{
  # TODO:
  #   - Proton Mail Bridge
  #   - Proton Drive set up home folders

  environment.systemPackages = with pkgs; [
    git
    gnupg
    jq
    ripgrep

    unstable.devenv
  ];

  environment.shellInit = ''
    eval "$(/opt/homebrew/bin/brew shellenv)"
  '';

  homebrew = {
    casks = [
      # "mac-mouse-fix"
      # "alacritty" # => we're using the home-manager package now
      # "bitwarden"
      # "brave-browser"
      # "docker"
      # "deepl"
      "ghostty"
      # "hot"
      # "ledger-live"
      # "mullvadvpn"
      "obsidian"
      "openaudible"

      "proton-drive"
      "proton-mail-bridge"
      "proton-pass"
      "protonvpn"

      "signal"
      # "tailscale"
      "tor-browser"
      "vlc"
      # "whatsapp"
      # "krunkit"
    ];

    masApps = {
      # "Bitwarden" = 1352778147;
      "Yubico Authenticator" = 1497506650;
      # "UTM Virtual Machines" = 1538878817; costs $9.99 in the app store
      # "Speechify" = 1624912180;
      # "DaVinci Resolve" = 571213070;
      # "Orbot" = 1609461599;

      # Safari Extensions
      # "AdGuard for Safari" = 1440147259;
      # "Bitwarden for Safari" = 1352778147;
      # "SimpleLogin" = 1494051017;
      # "Video Speed Controller" = 1588368612;
      # "Vimari" = 1480933944;
      # "XCode" = 497799835;
    };

    enable = true;
    onActivation.autoUpdate = true;
    onActivation.cleanup = "zap";
  };
}
