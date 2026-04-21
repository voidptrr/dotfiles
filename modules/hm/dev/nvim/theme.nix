{osConfig, ...}: let
  p = osConfig.nixos.theme.palette;
  isKanagawa = osConfig.nixos.theme.enable && osConfig.nixos.theme.name == "kanagawa";
  c = {
    bg0 = p.bg0 or "#181616";
    fg1 = p.fg1 or "#c5c9c5";
    red = p.red or "#c4746e";
    yellow = p.yellow or "#c4b28a";
    aqua = p.aqua or "#8ea4a2";
  };
  variant =
    if osConfig.nixos.theme.variant == "dragon"
    then "dragon"
    else "wave";
in {
  programs.nixvim = {
    colorschemes.kanagawa = {
      enable = isKanagawa;
      settings = {
        theme = variant;
        background = {
          dark = variant;
        };
        colors.theme.all.ui.bg_gutter = "none";
        transparent = false;
        terminalColors = true;
      };
    };

    highlight = {
      User1 = {
        bg = c.bg0;
        fg = c.aqua;
      };
      User2 = {
        bg = c.bg0;
        fg = c.yellow;
      };
      User3 = {
        bg = c.bg0;
        fg = c.fg1;
      };
      User4 = {
        bg = c.bg0;
        fg = c.fg1;
      };
      User5 = {
        bg = c.bg0;
        fg = c.red;
      };
    };
  };
}
