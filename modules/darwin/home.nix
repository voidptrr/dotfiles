{...}: {
  registry.darwinModules.home-manager-entry = {
    username,
    homeManagerModules ? [],
    ...
  }: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
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
