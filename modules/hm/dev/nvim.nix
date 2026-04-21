{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./nvim
  ];

  options.hm.dev.nvim.enable = lib.mkEnableOption "neovim";

  config = lib.mkIf config.hm.dev.nvim.enable {
    home.packages = [
      pkgs.xclip
      pkgs.wl-clipboard
    ];

    programs.nixvim.enable = true;
  };
}
