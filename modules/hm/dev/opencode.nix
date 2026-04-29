{
  lib,
  config,
  ...
}: {
  options.hm.dev.opencode.enable = lib.mkEnableOption "opencode";

  config = lib.mkIf config.hm.dev.opencode.enable {
    programs.opencode = {
      enable = true;
      tui.theme = "system";
    };
  };
}
