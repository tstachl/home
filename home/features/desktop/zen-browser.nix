{ outputs, ... }: {
  imports = [
    outputs.modules.home-manager.zen-browser
  ];

  programs.zen-browser = {
    enable = true;
    profiles.thomas = {
      isDefault = true;
    };
  };
}
