{
  nix.enable = true;

  system = {
    primaryUser = "thomas";

    keyboard = {
      enableKeyMapping = true;
      userKeyMapping = [
        {
          # map caps lock to skhd leader
          HIDKeyboardModifierMappingSrc = 30064771129;
          HIDKeyboardModifierMappingDst = 30064771298;
        }
      ];
    };

    defaults = {
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;

      dock = {
        autohide = true;
        expose-group-apps = true;
        orientation = "bottom";
        wvous-bl-corner = 10; # put display to sleep
        wvous-br-corner = 14; # quick note
        wvous-tl-corner = 1; # disabled
        wvous-tr-corner = 1; # disabled
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        CreateDesktop = true;
        _FXShowPosixPathInTitle = true;
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "clmv";
        QuitMenuItem = true;
        ShowPathbar = true;
        ShowStatusBar = true;
      };

      loginwindow = {
        DisableConsoleAccess = false;
        GuestEnabled = false;
        LoginwindowText = null;
        PowerOffDisabledWhileLoggedIn = false;
        RestartDisabled = false;
        RestartDisabledWhileLoggedIn = false;
        SHOWFULLNAME = true;
        ShutDownDisabled = false;
        ShutDownDisabledWhileLoggedIn = false;
        SleepDisabled = false;
        autoLoginUser = null;
      };

      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleKeyboardUIMode = 3;
        ApplePressAndHoldEnabled = false;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        KeyRepeat = 1;
        InitialKeyRepeat = 12;
        NSAutomaticCapitalizationEnabled = false;
        NSDocumentSaveNewDocumentsToCloud = true;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        NSWindowResizeTime = 0.001;
        PMPrintingExpandedStateForPrint = true;
        PMPrintingExpandedStateForPrint2 = true;
        # WebKitDeveloperExtras = true;
        _HIHideMenuBar = true;
        "com.apple.swipescrolldirection" = true;
        # "com.apple.BezelServices" = 5;
      };

      screencapture.location = "/tmp";

      screensaver.askForPassword = true;

      trackpad = {
        ActuationStrength = 0;
        Clicking = true;
        Dragging = null;
        FirstClickThreshold = 1;
        SecondClickThreshold = 1;
        TrackpadRightClick = null;
        TrackpadThreeFingerDrag = true;
      };

      WindowManager.StageManagerHideWidgets = true;
      WindowManager.StandardHideDesktopIcons = true;
      WindowManager.StandardHideWidgets = true;
    };

    rosetta.enable = true;
  };

  security.pam.services.sudo_local.touchIdAuth = true;
  security.pam.enablePamReattach = true;
}
