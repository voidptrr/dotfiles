{
  config,
  self,
  ...
}: {
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
        firefox.enable = true;
        git = {
          enable = true;
          name = "voidptrr";
          email = "bruno.tommaso@protonmail.com";
          signingKeyPath = config.age.secrets.gitSigningKey.path;
        };
        ghostty.enable = true;
        neovim.enable = true;
        opencode.enable = true;
        ssh.authenticationKeyPath = config.age.secrets.githubSshKey.path;
        zsh.enable = true;
      };
    };
  };
}
