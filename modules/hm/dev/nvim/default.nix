{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.hm.dev.nvim.enable = lib.mkEnableOption "neovim";

  config = lib.mkIf config.hm.dev.nvim.enable {
    home.packages = [
      inputs.nvim-config.packages.${pkgs.system}.default
      pkgs.xclip
      pkgs.wl-clipboard
    ];
  };
}
