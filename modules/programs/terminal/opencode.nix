{...}: {
  flake.homeManagerModules.opencode = {...}: {
    programs.opencode = {
      enable = true;
      tui = {
        theme = "kanagawa";
      };
    };
  };
}
