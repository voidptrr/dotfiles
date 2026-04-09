{
  self,
  inputs,
}: {
  system,
  configuration,
  username ? null,
  hardwareModules ? [],
  extraModules ? [],
}:
inputs.nixpkgs.lib.nixosSystem {
  inherit system;

  specialArgs = {
    inherit username;
  };

  modules =
    hardwareModules
    ++ builtins.attrValues self.sharedModules
    ++ [
      (import ./nix-config.nix)
      configuration
    ]
    ++ extraModules;
}
