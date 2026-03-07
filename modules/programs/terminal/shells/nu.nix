{...}: {
  flake.homeManagerModules.nu = {
    pkgs,
    config,
    ...
  }: let
    cfg = config.programs.shellProfile;
  in {
    programs.nushell = {
      enable = true;
      package = pkgs.nushell;

      shellAliases =
        cfg.shellAliases
        // {
          nd = "nix develop -c nu";
        };

      environmentVariables = cfg.environmentVariables;
    };
  };
}
