{...}: {
  programs.nixvim = {
    extraFiles = {
      "after/ftplugin/nix.lua".text = ''
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
      '';
    };
  };
}
