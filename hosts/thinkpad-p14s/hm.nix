{...}: {
  hm = {
    shell.zsh.enable = true;
    terminal = {
      alacritty.enable = true;
      tmux.enable = true;
    };
    browser.firefox.enable = true;

    dev = {
      git = {
        enable = true;
        name = "voidptrr";
        email = "bruno.tommaso@protonmail.com";
      };

      opencode.enable = true;
      nvim.enable = true;
    };
  };
}
