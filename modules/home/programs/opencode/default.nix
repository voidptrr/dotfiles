{
  lib,
  config,
  ...
}: {
  options.my.home.programs.opencode.enable = lib.mkEnableOption "opencode";

  config = lib.mkIf config.my.home.programs.opencode.enable {
    programs.opencode = {
      enable = true;
      tui.theme = "system";
    };

    programs.codex.enable = true;

    home.file.".agents/skills" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/config/agents/skills";
      recursive = true;
    };
  };
}
