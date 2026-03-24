{...}: {
  flake.homeManagerModules.opencode = {...}: {
    programs.opencode = {
      enable = true;
      settings = {
        theme = "everforest";
      };
    };
  };
}
