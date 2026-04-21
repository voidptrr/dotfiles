{
  config,
  lib,
  ...
}: let
  themePalettes = {
    kanagawa = {
      dragon = {
        bg0 = "#181616";
        bg1 = "#282727";
        bg2 = "#393836";
        bg3 = "#4b4a47";
        black = "#000000";
        fg0 = "#f5f2d5";
        fg1 = "#c5c9c5";
        fg2 = "#a6a69c";
        fg3 = "#8a8a80";
        fg_dim = "#a6a69c";
        gray = "#7a8382";
        red = "#c4746e";
        green = "#8a9a7b";
        yellow = "#c4b28a";
        dragonYellow = "#c4b28a";
        blue = "#8ba4b0";
        waveBlue2 = "#8ba4b0";
        aqua = "#8ea4a2";
        waveAqua2 = "#8ea4a2";
        purple = "#a292a3";
        orange = "#b6927b";
        waveRed = "#c4746e";
        sumiInk2 = "#282727";
        sumiInk3 = "#393836";
        sumiInk4 = "#4b4a47";
      };
    };
  };

  themeVariants = builtins.attrNames themePalettes.${config.nixos.theme.name};
in {
  options.nixos.theme = {
    enable = lib.mkEnableOption "shared desktop theme palette";

    name = lib.mkOption {
      type = lib.types.enum (builtins.attrNames themePalettes);
      default = "kanagawa";
      description = "Theme family name.";
    };

    variant = lib.mkOption {
      type = lib.types.str;
      default = "dragon";
      description = "Theme variant for the selected theme family.";
    };

    palette = lib.mkOption {
      type = with lib.types; attrsOf str;
      default = {};
      description = "Computed semantic color palette for the selected theme.";
    };
  };

  config = {
    assertions = [
      {
        assertion = builtins.elem config.nixos.theme.variant themeVariants;
        message = "nixos.theme.variant '${config.nixos.theme.variant}' is not valid for theme '${config.nixos.theme.name}'";
      }
    ];

    nixos.theme.palette =
      if config.nixos.theme.enable
      then themePalettes.${config.nixos.theme.name}.${config.nixos.theme.variant}
      else {};
  };
}
