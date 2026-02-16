{pkgs, ...}: let
  koda = pkgs.vimUtils.buildVimPlugin {
    pname = "koda.nvim";
    version = "main";
    src = pkgs.fetchFromGitHub {
      owner = "oskarnurm";
      repo = "koda.nvim";
      rev = "main";
      sha256 = "sha256-kErR1LB4K/RAFKcSUV/VnQajtGVFj+0rdvNn84hWpUY=";
    };
  };
in {
  extraPlugins = [koda];
  extraConfigLua = ''
    require("koda").setup({
      styles = {
        functions = { bold = true, italic = false },
        keywords = { italic = false },
        comments = { italic = false },
        strings = { italic = false },
        constants = { italic = false },
      },
    })
    vim.cmd.colorscheme("koda")
  '';
}
