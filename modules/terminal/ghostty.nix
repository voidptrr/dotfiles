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

        background = "#0d0d0d";
        window-width = 144;
        window-height = 43;
      };
    };
  };
}
