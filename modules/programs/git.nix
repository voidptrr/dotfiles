{lib, ...}: {
  flake.homeManagerModules.git = {
    config,
    pkgs,
    ...
  }: let
    cfg = config.programs.gitProfile;
  in {
    options.programs.gitProfile = {
      name = lib.mkOption {
        type = lib.types.str;
      };
      email = lib.mkOption {
        type = lib.types.str;
      };
    };

    config = {
      assertions = [
        {
          assertion = cfg.name != null && cfg.name != "";
          message = "programs.gitProfile.name must be set.";
        }
        {
          assertion = cfg.email != null && cfg.email != "";
          message = "programs.gitProfile.email must be set.";
        }
      ];

      programs.git = {
        enable = true;

        signing = {
          signByDefault = true;
          key = "~/.ssh/id_ed25519.pub";
          format = "ssh";
        };

        settings =
          {
            user = {
              name = cfg.name;
              email = cfg.email;
            };
            push.autoSetupRemote = true;
            init.defaultBranch = "main";
            pull.rebase = true;
          }
          // lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
            safe.directory = "/etc/nix-darwin";
          };
      };
    };
  };
}
