{lib, ...}: {
  flake.sharedModules.git = {
    options.shared.git = {
      name = lib.mkOption {
        type = lib.types.nonEmptyStr;
      };

      email = lib.mkOption {
        type = lib.types.nonEmptyStr;
      };

      signingKeyPath = lib.mkOption {
        type = lib.types.nonEmptyStr;
        description = "Absolute path to the SSH signing key used by git.";
      };
    };
  };

  flake.homeManagerModules.git = {osConfig, ...}: {
    programs.git = {
      enable = true;

      signing = {
        key = osConfig.shared.git.signingKeyPath;
        signByDefault = true;
      };

      settings = {
        user = {
          name = osConfig.shared.git.name;
          email = osConfig.shared.git.email;
        };

        gpg.format = "ssh";
        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };
  };
}
