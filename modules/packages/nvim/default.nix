{
  inputs,
  self,
  ...
}: {
  flake.homeManagerModules.nvim = {pkgs, ...}: {
    home.packages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.nvim
    ];
  };

  perSystem = {system, ...}: {
    packages.nvim = let
      nixvim' = inputs.nixvim.legacyPackages.${system};
      nixvimModule = {
        inherit system;
        module = import ./_config/module.nix;
      };
    in
      nixvim'.makeNixvimWithModule nixvimModule;
  };
}
