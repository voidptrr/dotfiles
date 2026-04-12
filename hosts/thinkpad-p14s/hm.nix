{...}: {
  hm = {
    shell.zsh.enable = true;
    terminal.ghostty.enable = true;
    browser.firefox.enable = true;

    dev = {
      git = {
        enable = true;
        name = "voidptrr";
        email = "bruno.tommaso@protonmail.com";
      };

      nvim.enable = true;
      opencode.enable = true;
    };
  };
}
