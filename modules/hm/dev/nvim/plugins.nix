{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.hm.dev.vim;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
      vim-fugitive
    ];
  };
}
