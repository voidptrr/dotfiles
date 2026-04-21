{...}: {
  programs.nixvim = {
    plugins."blink-cmp" = {
      enable = true;
      settings = {
        keymap = {
          preset = "default";
          "<C-n>" = ["select_next" "fallback"];
          "<Down>" = ["select_next" "fallback"];
          "<C-p>" = ["select_prev" "fallback"];
          "<Up>" = ["select_prev" "fallback"];
          "<C-y>" = ["accept" "fallback"];
        };
        completion.documentation = {
          auto_show = true;
          auto_show_delay_ms = 200;
        };
      };
    };
  };
}
