{...}: {
  flake.homeManagerModules.ghostty = {pkgs, ...}: {
    programs.ghostty = {
      enable = true;
      package =
        if pkgs.stdenv.hostPlatform.isLinux
        then pkgs.ghostty
        else pkgs.ghostty-bin;

      enableZshIntegration = true;
      settings = {
        font-size = 15;
        font-thicken = true;
        font-thicken-strength = 100;
        font-family = "Source Code Pro";

        theme = "Everforest Dark Hard";

        window-width = 144;
        window-height = 43;
      };
    };
  };
}
