{
  self,
  inputs,
}: {
  system,
  username,
  hostModule,
}:
inputs.nix-darwin.lib.darwinSystem {
  inherit system;

  specialArgs = {
    inherit username;
    homeManagerModules = builtins.attrValues self.homeManagerModules;
  };

  modules =
    builtins.attrValues self.darwinModules
    ++ builtins.attrValues self.sharedModules
    ++ [
      (import ./nix-config.nix)
      hostModule
      inputs.nix-homebrew.darwinModules.nix-homebrew
      inputs.home-manager.darwinModules.home-manager
    ];
}
