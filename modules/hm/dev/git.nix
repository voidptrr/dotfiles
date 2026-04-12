{
  lib,
  config,
  ...
}: {
  options.hm.dev.git = {
    enable = lib.mkEnableOption "git";

    name = lib.mkOption {
      type = with lib.types; nullOr nonEmptyStr;
      default = null;
    };

    email = lib.mkOption {
      type = with lib.types; nullOr nonEmptyStr;
      default = null;
    };
  };

  config = lib.mkIf config.hm.dev.git.enable {
    assertions = [
      {
        assertion = config.hm.dev.git.name != null;
        message = "hm.dev.git.name must be set when hm.dev.git.enable is true";
      }
      {
        assertion = config.hm.dev.git.email != null;
        message = "hm.dev.git.email must be set when hm.dev.git.enable is true";
      }
    ];

    programs.git = {
      enable = true;
      settings = {
        user = {
          name = config.hm.dev.git.name;
          email = config.hm.dev.git.email;
        };

        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };
  };
}
