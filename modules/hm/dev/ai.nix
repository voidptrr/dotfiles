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

    programs.codex.enable = true;

    home.file.".agents/skills" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/config/agents/skills";
      recursive = true;
    };
  };
}
