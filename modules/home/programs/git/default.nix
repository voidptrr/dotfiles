{
  lib,
  config,
  ...
}: let
  cfg = config.my.home.programs.git;
in {
  options.my.home.programs.git = {
    enable = lib.mkEnableOption "git";

    name = lib.mkOption {
      type = with lib.types; nonEmptyStr;
    };

    email = lib.mkOption {
      type = with lib.types; nonEmptyStr;
    };

    authenticationKeyPath = lib.mkOption {
      type = with lib.types; nullOr nonEmptyStr;
      default = null;
      description = "Path to the SSH private key used for github.com.";
    };

    signingKeyPath = lib.mkOption {
      type = with lib.types; nullOr nonEmptyStr;
      default = null;
      description = "Path to the SSH private key used for signing commits and tags.";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.name != null;
        message = "my.home.programs.git.name must be set when my.home.programs.git.enable is true";
      }
      {
        assertion = cfg.email != null;
        message = "my.home.programs.git.email must be set when my.home.programs.git.enable is true";
      }
    ];

    programs.git = {
      enable = true;
      settings = {
        user = {
          name = cfg.name;
          email = cfg.email;
          signingKey = cfg.signingKeyPath;
        };

        gpg.format = lib.mkIf (cfg.signingKeyPath != null) "ssh";
        commit.gpgSign = cfg.signingKeyPath != null;
        tag.gpgSign = cfg.signingKeyPath != null;
        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };

    programs.ssh = {
      enable = cfg.authenticationKeyPath != null;
      settings."github.com" = lib.mkIf (cfg.authenticationKeyPath != null) {
        HostName = "github.com";
        User = "git";
        IdentityFile = cfg.authenticationKeyPath;
        IdentitiesOnly = true;
      };
    };
  };
}
