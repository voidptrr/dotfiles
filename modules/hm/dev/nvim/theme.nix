{osConfig, ...}: let
  p = osConfig.nixos.theme.palette;
  isKanagawa = osConfig.nixos.theme.enable && osConfig.nixos.theme.name == "kanagawa";
  c = {
    bg0 = p.bg0 or "#181616";
    bg1 = p.bg1 or "#282727";
    bg2 = p.bg2 or "#393836";
    fg1 = p.fg1 or "#c5c9c5";
    fg2 = p.fg2 or "#a6a69c";
    red = p.red or "#c4746e";
    yellow = p.yellow or "#c4b28a";
    blue = p.blue or "#8ba4b0";
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
      Pmenu = {
        bg = c.bg1;
      };
      PmenuSel = {
        bg = c.bg2;
        fg = c.fg1;
      };
      PmenuKind = {
        bg = c.bg1;
        fg = c.fg1;
      };
      PmenuKindSel = {
        bg = c.bg2;
        fg = c.fg1;
      };
      PmenuExtra = {
        bg = c.bg1;
        fg = c.fg2;
      };
      PmenuExtraSel = {
        bg = c.bg2;
        fg = c.fg2;
      };
      PmenuSbar = {
        bg = c.bg0;
      };
      PmenuThumb = {
        bg = c.blue;
      };

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
