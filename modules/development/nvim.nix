{self, ...}: {
  flake.devModules.nvim = {pkgs, ...}: {
    home.packages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.nvim
    ];
  };
}
