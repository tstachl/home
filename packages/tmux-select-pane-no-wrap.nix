{ mkTmuxPlugin, fetchFromGitHub }:
mkTmuxPlugin rec {
  pluginName = "tmux-select-pane-no-wrap";
  version = "00add78";
  src = fetchFromGitHub {
    owner = "dalejung";
    repo = pluginName;
    rev = version;
    sha256 = "";
  };
}
