{
  config,
  lib,
  ...
}: {
  options.registry = {
    darwinModules = lib.mkOption {
      type = lib.types.attrsOf lib.types.raw;
      default = {};
      description = "Registry of nix-darwin modules.";
    };

    homeManagerModules = lib.mkOption {
      type = lib.types.attrsOf lib.types.raw;
      default = {};
      description = "Registry of Home Manager modules.";
    };

    nixModules = lib.mkOption {
      type = lib.types.attrsOf lib.types.raw;
      default = {};
      description = "Registry of shared Nix modules.";
    };

    hostModules = lib.mkOption {
      type = lib.types.attrsOf lib.types.raw;
      default = {};
      description = "Registry of host-specific modules.";
    };
  };

  config.flake = {
    darwinModules = config.registry.darwinModules;
    homeManagerModules = config.registry.homeManagerModules;
    nixModules = config.registry.nixModules;
    hostModules = config.registry.hostModules;
  };
}
