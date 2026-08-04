{inputs, ...}: {
  imports = [
    inputs.git-hooks.flakeModule
  ];

  perSystem = _: {
    pre-commit.settings.hooks = {
      check.enable = true;
      alejandra.enable = true;
    };
  };
}
