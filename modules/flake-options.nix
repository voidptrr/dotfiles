{lib, ...}: {
  options.flake = {
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

    sharedModules = lib.mkOption {
      type = lib.types.attrsOf lib.types.raw;
      default = {};
      description = "Registry of shared modules.";
    };

    hostModules = lib.mkOption {
      type = lib.types.attrsOf lib.types.raw;
      default = {};
      description = "Registry of host-specific modules.";
    };
  };
}
