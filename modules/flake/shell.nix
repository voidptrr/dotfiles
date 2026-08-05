{...}: {
  perSystem = {
    config,
    inputs',
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      shellHook = config.pre-commit.installationScript;

      packages = [
        pkgs.nil
        inputs'.ragenix.packages.default
      ];
    };
  };
}
