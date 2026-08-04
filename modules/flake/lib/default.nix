{inputs, ...}: let
  inherit (inputs.nixpkgs) lib;
in {
  flake.lib = {
    fs = import ./fs.nix {inherit lib;};
  };
}
