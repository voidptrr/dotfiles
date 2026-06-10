{
  inputs,
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.hm.dev.vim;
in {
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./nvim/files.nix
    ./nvim/keymaps.nix
    ./nvim/options.nix
    ./nvim/plugins.nix
    ./nvim/ui.nix
  ];

  options.hm.dev.vim.enable = lib.mkEnableOption "neovim";

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      globals = {
        mapleader = ",";
        c_syntax_for_h = 1;

        netrw_dirhistmax = 0;
        netrw_banner = 1;
        netrw_liststyle = 0;
        netrw_browse_split = 0;
        netrw_winsize = 25;
        netrw_altv = 1;
        netrw_localcopydircmd = "cp -r";
      };
    };
  };
}
