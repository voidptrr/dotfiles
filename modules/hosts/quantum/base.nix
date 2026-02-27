{
  self,
  inputs,
  ...
}: let
  system = "aarch64-darwin";
  username = "voidptr";

  darwinStack = [
    self.darwinModules.system
    self.darwinModules.dock
    self.darwinModules.homebrew
    self.darwinModules.quantum
    self.darwinModules.home-manager-entry
    self.nixModules.base
  ];

  homeModules = builtins.attrValues self.homeManagerModules;
in {
  flake.darwinConfigurations.personal = inputs.nix-darwin.lib.darwinSystem {
    inherit system;
    specialArgs = {
      inherit username;
      homeManagerModules = homeModules;
    };
    modules =
      darwinStack
      ++ [
        inputs.nix-homebrew.darwinModules.nix-homebrew
        inputs.home-manager.darwinModules.home-manager
      ];
  };
}
