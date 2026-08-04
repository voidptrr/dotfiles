{lib, ...}: {
  options.my.snippets.nix.settings = lib.mkOption {
    type = lib.types.attrs;
    description = "Default nix settings shared across machines.";

    default = {
      auto-optimise-store = true;
      warn-dirty = false;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
