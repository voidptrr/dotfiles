{self, ...}: {
  home-manager.users.voidptr = {
    imports = builtins.attrValues self.homeModules;

    home = {
      homeDirectory = "/home/voidptr";
      stateVersion = "26.05";
      username = "voidptr";
    };

    programs.home-manager.enable = true;

    my.home = {
      desktop.i3.enable = true;

      programs = {
        alacritty.enable = true;
        firefox.enable = true;
        git = {
          enable = true;
          name = "voidptrr";
          email = "bruno.tommaso@protonmail.com";
        };
        neovim.enable = true;
        opencode.enable = true;
        zsh.enable = true;
      };
    };
  };
}
