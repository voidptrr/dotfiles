{
  lib,
  config,
  ...
}: let
  cfg = config.hm.dev.vim;
in {
  config = lib.mkIf cfg.enable {
    xdg.configFile."nvim/colors/smoke.vim".source = ./colors/smoke.vim;
  };
}
