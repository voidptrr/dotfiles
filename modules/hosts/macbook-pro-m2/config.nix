{self, ...}: {
  registry.hostModules.macbook-pro-m2 = {config, ...}: {
    imports = [self.hostModules.macbook-pro-m2-secrets];

    shared = {
      git = {
        name = "voidptrr";
        email = "bruno.tommaso@protonmail.com";
        signingKeyPath = config.sops.secrets.git-signing-key.path;
      };
    };

    darwin = {
      skhd = {
        enable = true;
        config = ''
          cmd - g : /bin/sh -lc 'nohup ghostty </dev/null >/tmp/ghostty-skhd.log 2>&1 &'
          cmd - b : /usr/bin/open -a "Firefox"
        '';
      };

      homebrew = {
        brews = ["mole"];
        casks = ["firefox"];
        masApps = {
          KakaoTalk = 869223134;
        };
      };

      dock.persistentApps = [
        "/System/Applications/Music.app"
        "/Applications/Kakaotalk.app"
        "/Applications/Firefox.app"
      ];
    };
  };
}
