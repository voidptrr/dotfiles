{
  lib,
  config,
  ...
}: let
  cfg = config.hm.dev.vim;
  twoSpaceIndent = {
    tabstop = 2;
    shiftwidth = 2;
    softtabstop = 2;
  };
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim.opts = {
      swapfile = false;
      backup = false;
      writebackup = false;
      ignorecase = true;
      smartcase = true;
      mouse = "a";
      scrolloff = 10;
      backspace = "indent,eol,start";
      splitbelow = true;
      splitright = true;
      updatetime = 250;
      clipboard = "unnamedplus";

      expandtab = true;
      tabstop = 4;
      shiftwidth = 4;
      softtabstop = 4;
      autoindent = true;
      smartindent = true;

      wildmenu = true;
      laststatus = 2;
      background = "dark";
      termguicolors = true;
    };

    programs.nixvim.files = {
      "ftplugin/json.lua".localOpts = twoSpaceIndent;
      "ftplugin/nix.lua".localOpts = twoSpaceIndent;
      "ftplugin/typescript.lua".localOpts = twoSpaceIndent;
    };

    programs.nixvim.extraConfigVim = ''
      set path+=**
      set wildignore+=*/build/*,*/.git/*,*/dist/*,*/node_modules/*
    '';
  };
}
