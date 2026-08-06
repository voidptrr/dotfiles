{
  lib,
  config,
  ...
}: let
  cfg = config.my.home.programs.ssh;
in {
  options.my.home.programs.ssh.authenticationKeyPath = lib.mkOption {
    type = with lib.types; nullOr nonEmptyStr;
    default = null;
    description = "Path to the SSH private key used for github.com.";
  };

  config = {
    programs.ssh = {
      enable = true;
      settings."github.com" = lib.mkIf (cfg.authenticationKeyPath != null) {
        HostName = "github.com";
        User = "git";
        IdentityFile = cfg.authenticationKeyPath;
        IdentitiesOnly = true;
      };
    };
  };
}
