{...}: {
  registry.homeManagerModules.opencode = {...}: {
    programs.opencode = {
      enable = true;
      settings = {
        plugin = [];
        theme = "everforest";
        provider = {};
      };
    };
  };
}
