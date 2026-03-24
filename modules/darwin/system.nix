{...}: {
  flake.darwinModules.system = {
    pkgs,
    username,
    ...
  }: {
    programs.zsh.enable = true;

    environment = {
      shells = [pkgs.zsh];
      pathsToLink = ["/share/zsh"];
      systemPackages = with pkgs; [man-pages-posix];
    };

    users.knownUsers = [username];
    users.users.${username} = {
      name = username;
      uid = 501;
      gid = 20;
      home = "/Users/${username}";
      shell = "${pkgs.zsh}/bin/zsh";
    };

    fonts.packages = with pkgs; [
      jetbrains-mono
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
