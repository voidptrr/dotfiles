{
  lib,
  config,
  ...
}: let
  cfg = config.hm.dev.vim;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim.colorschemes.gruvbox-material = {
      enable = true;
      settings = {
        background = "soft";
        foreground = "material";
        transparent_background = 1;
        better_performance = 1;
      };
    };

    programs.nixvim.plugins.lualine = {
      enable = true;
      settings = {
        options = {
          icons_enabled = false;
          component_separators = "";
          section_separators = "";
          globalstatus = false;
          theme = "gruvbox-material";
        };
        sections = {
          lualine_a = ["mode"];
          lualine_b = ["branch"];
          lualine_c = [
            {
              __unkeyed-1 = "filename";
              path = 1;
            }
          ];
          lualine_x = ["filetype"];
          lualine_y = ["progress"];
          lualine_z = ["location"];
        };
        inactive_sections = {
          lualine_a = [];
          lualine_b = [];
          lualine_c = [
            {
              __unkeyed-1 = "filename";
              path = 1;
            }
          ];
          lualine_x = ["location"];
          lualine_y = [];
          lualine_z = [];
        };
        extensions = [
          "fugitive"
          "quickfix"
        ];
      };
    };
  };
}
