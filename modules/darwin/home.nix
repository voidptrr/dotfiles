{...}: {
  flake.darwinModules.home-manager-entry = {
    username,
    pkgs,
    homeManagerModules ? [],
    ...
  }: {
    programs.zsh.enable = true;
    environment = {
      shells = [pkgs.zsh];
      pathsToLink = ["/share/zsh"];
    };

    users.knownUsers = [username];
    users.users.${username} = {
      name = username;
      home = "/Users/${username}";
      uid = 501;
      gid = 20;
      shell = "${pkgs.zsh}/bin/zsh";
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      users.${username} = {
        home.username = username;
        home.stateVersion = "25.11";
        home.homeDirectory = "/Users/${username}";

        programs.home-manager.enable = true;
      };
      sharedModules = homeManagerModules;
    };
  };
}
