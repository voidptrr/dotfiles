{...}: {
  flake.devModules.opencode = {...}: {
    programs.opencode = {
      enable = true;
      settings = {
        plugin = [];
        theme = "gruvbox";
        provider = {};
      };
    };
  };
}
