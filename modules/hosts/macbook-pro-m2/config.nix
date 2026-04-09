{self, ...}: {
  flake.hostModules.macbook-pro-m2 = {
    config,
    pkgs,
    ...
  }: {
    imports = [self.hostModules.macbook-pro-m2-secrets];

    git = {
      name = "voidptrr";
      email = "bruno.tommaso@protonmail.com";
      signingKeyPath = config.sops.secrets.git-signing-key.path;
    };

    darwin = {
      homebrew = {
        brews = ["mole"];
        casks = ["firefox"];
        masApps = {
          #KakaoTalk = 869223134;
        };
      };

      dock.persistentApps = [
        "/System/Applications/Music.app"
        "/Applications/Firefox.app"
        "${pkgs.ghostty-bin}/Applications/Ghostty.App"
      ];
    };
  };
}
