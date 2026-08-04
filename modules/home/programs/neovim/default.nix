{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.my.home.programs.neovim.enable = lib.mkEnableOption "neovim";

  config = lib.mkIf config.my.home.programs.neovim.enable {
    home.packages = [
      inputs.nvim-config.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.xclip
      pkgs.wl-clipboard
    ];
  };
}
