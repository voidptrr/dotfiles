{
  lib,
  config,
  ...
}: {
  options.my.home.programs.git = {
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

  config = lib.mkIf config.my.home.programs.git.enable {
    assertions = [
      {
        assertion = config.my.home.programs.git.name != null;
        message = "my.home.programs.git.name must be set when my.home.programs.git.enable is true";
      }
      {
        assertion = config.my.home.programs.git.email != null;
        message = "my.home.programs.git.email must be set when my.home.programs.git.enable is true";
      }
    ];

    programs.git = {
      enable = true;
      settings = {
        user = {
          name = config.my.home.programs.git.name;
          email = config.my.home.programs.git.email;
        };

        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };
  };
}
