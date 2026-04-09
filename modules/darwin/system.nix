{...}: {
  flake.darwinModules.system = {
    pkgs,
    username,
    ...
  }: {
    fonts.packages = with pkgs; [
      source-code-pro
    ];

    system = {
      stateVersion = 6;
      primaryUser = username;
      keyboard = {
        enableKeyMapping = true;
        remapCapsLockToEscape = true;
      };
      defaults = {
        NSGlobalDomain = {
          AppleIconAppearanceTheme = "RegularDark";
          AppleInterfaceStyle = "Dark";
          AppleShowScrollBars = "WhenScrolling";
          AppleTemperatureUnit = "Celsius";
          NSAutomaticCapitalizationEnabled = false;
          NSDocumentSaveNewDocumentsToCloud = false;
          NSAutomaticWindowAnimationsEnabled = false;
        };
        SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;

        WindowManager = {
          StageManagerHideWidgets = true;
          StandardHideDesktopIcons = true;
          StandardHideWidgets = true;
        };

        finder = {
          AppleShowAllExtensions = true;
          AppleShowAllFiles = true;
          CreateDesktop = false;
          FXDefaultSearchScope = "SCcf";
          FXEnableExtensionChangeWarning = false;
          FXPreferredViewStyle = "clmv";
          FXRemoveOldTrashItems = true;
          NewWindowTarget = "Home";
          ShowPathbar = true;
          ShowStatusBar = true;
          _FXShowPosixPathInTitle = true;
        };

        loginwindow = {
          GuestEnabled = false;
          SHOWFULLNAME = false;
        };

        CustomSystemPreferences = {
          "com.apple.AdLib" = {
            allowApplePersonalizedAdvertising = false;
            allowAssistant = false;
          };
        };
      };
    };
  };
}
