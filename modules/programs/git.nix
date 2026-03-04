{lib, ...}: {
  flake.homeManagerModules.git = {config, ...}: let
    cfg = config.programs.gitProfile;
  in {
    options.programs.gitProfile = {
      name = lib.mkOption {
        type = lib.types.nonEmptyStr;
      };
      email = lib.mkOption {
        type = lib.types.nonEmptyStr;
      };
    };

    config = {
      sops.secrets.git-signing-key = {
        path = "${config.home.homeDirectory}/.ssh/git_signing_ed25519";
        mode = "0400";
      };

      programs.git = {
        enable = true;

        signing = {
          signByDefault = true;
          key = config.sops.secrets.git-signing-key.path;
          format = "ssh";
        };

        settings = {
          user = {
            name = cfg.name;
            email = cfg.email;
          };
          push.autoSetupRemote = true;
          init.defaultBranch = "main";
          pull.rebase = true;
        };
      };
    };
  };
}
