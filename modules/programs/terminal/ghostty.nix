{lib, ...}: {
  flake.homeManagerModules.ghostty = {pkgs, ...}: {
    programs.ghostty = {
      enable = true;
      package =
        if pkgs.stdenv.hostPlatform.isDarwin
        then pkgs.ghostty-bin
        else pkgs.ghostty;
      settings =
        {
          font-family = "JetBrains Mono";
          maximize = true;
          working-directory = "home";
          window-inherit-working-directory = false;
        }
        // lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
          macos-titlebar-style = "hidden";
          macos-icon = "chalkboard";
        };
    };
  };
}
