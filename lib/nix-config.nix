{...}: {
  nix.settings = {
    auto-optimise-store = true;
    warn-dirty = false;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "Sun 10:00";
    options = "--delete-older-than 2d";
  };
}
