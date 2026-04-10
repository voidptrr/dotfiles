{
  lib,
  config,
  ...
}: {
  options.dev.git = {
    name = lib.mkOption {
      type = lib.types.nonEmptyStr;
    };

    email = lib.mkOption {
      type = lib.types.nonEmptyStr;
    };
  };

  config.programs.git = {
    enable = true;
    settings = {
      user = {
        name = config.dev.git.name;
        email = config.dev.git.email;
      };

      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
