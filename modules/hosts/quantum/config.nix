{...}: {
  flake.darwinModules.quantum = {pkgs, ...}: {
    homebrewConfig = {
      brews = ["mole"];
      casks = ["firefox"];
      masApps = {
        KakaoTalk = 869223134;
      };
    };
    dockConfig.persistentApps = map (app: {inherit app;}) [
      "/System/Applications/Music.app"
      "/Applications/Kakaotalk.app"
      "/Applications/Firefox.app"
      "${
        (
          if pkgs.stdenv.hostPlatform.isDarwin
          then pkgs.ghostty-bin
          else pkgs.ghostty
        )
      }/Applications/Ghostty.app"
    ];
    home-manager.sharedModules = [
      {
        programs.gitProfile = {
          name = "voidptrr";
          email = "bruno.tommaso@protonmail.com";
        };
      }
    ];
  };
}
