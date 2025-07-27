{ fetchFromGitHub
, tmuxPlugins
,
}:
tmuxPlugins.mkTmuxPlugin rec {
  pluginName = "tmux-select-pane-no-wrap";
  version = "00add78";
  src = fetchFromGitHub {
    owner = "dalejung";
    repo = pluginName;
    rev = version;
    sha256 = "sha256-ot0cHvk1TXvHOw9z+7TLSiHT77jHwvV2PSHcNuhOorQ=";
  };
}
