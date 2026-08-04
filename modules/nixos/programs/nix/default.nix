{
  config,
  lib,
  ...
}: {
  options.my.nixos.programs.nix.enable = lib.mkEnableOption "sane nix configuration";

  config = lib.mkIf config.my.nixos.programs.nix.enable {
    nix = {
      gc = {
        automatic = true;
        dates = "Sun 10:00";
        options = "--delete-older-than 2d";
      };

      settings = config.my.snippets.nix.settings;
    };
  };
}
