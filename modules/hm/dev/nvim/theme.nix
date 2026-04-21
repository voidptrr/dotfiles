{osConfig, ...}: let
  isKanagawa = osConfig.nixos.theme.enable && osConfig.nixos.theme.name == "kanagawa";
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
        overrides.__raw = ''
          function(colors)
            local black_color = "#000000"
            return {
              Pmenu = { bg = colors.palette.sumiInk3 },
              PmenuSel = { bg = colors.palette.sumiInk4, fg = colors.palette.fujiWhite },
              PmenuKind = { bg = colors.palette.sumiInk3, fg = colors.palette.fujiWhite },
              PmenuKindSel = { bg = colors.palette.sumiInk4, fg = colors.palette.fujiWhite },
              PmenuExtra = { bg = colors.palette.sumiInk3, fg = colors.theme.ui.fg_dim },
              PmenuExtraSel = { bg = colors.palette.sumiInk4, fg = colors.theme.ui.fg_dim },
              PmenuSbar = { bg = colors.palette.sumiInk2 },
              PmenuThumb = { bg = colors.palette.waveBlue2 },
              User1 = { bg = black_color, fg = colors.palette.waveAqua2 },
              User2 = { bg = black_color, fg = colors.palette.dragonYellow },
              User3 = { bg = black_color, fg = colors.theme.ui.fg },
              User4 = { bg = black_color, fg = colors.theme.ui.fg },
              User5 = { bg = black_color, fg = colors.palette.waveRed },
            }
          end
        '';
      };
    };
  };
}
