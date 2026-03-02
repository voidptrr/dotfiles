{
  inputs,
  lib,
  ...
}: {
  flake.homeManagerModules.sops = {config, ...}: {
    imports = [inputs.sops-nix.homeManagerModules.sops];

    options.programs.sopsProfile = {
      ageKeyFile = lib.mkOption {
        type = lib.types.str;
        default = "${config.home.homeDirectory}/sops/age/keys.txt";
      };
    };

    config.sops = {
      defaultSopsFile = ../../secrets/secrets.yaml;
      age.keyFile = config.programs.sopsProfile.ageKeyFile;
    };
  };
}
