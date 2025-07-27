{ pkgs
, outputs
, ...
}: {
  imports = [
    outputs.modules.global

    ./home-manager.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      git
      ripgrep
      jq
    ];
  };
}
