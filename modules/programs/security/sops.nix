{inputs, ...}: {
  flake.homeManagerModules.sops = {
    config,
    lib,
    ...
  }: {
    imports = [inputs.sops-nix.homeManagerModules.sops];

    options.programs.sopsProfile = {
      ageKeyFile = lib.mkOption {
        type = lib.types.str;
        default = "${config.home.homeDirectory}/sops/age/keys.txt";
      };
    };

    config = {
      sops = {
        defaultSopsFile = ../../../secrets/secrets.yaml;
        age.keyFile = config.programs.sopsProfile.ageKeyFile;

        secrets.git-signing-key = {
          path = "${config.home.homeDirectory}/.ssh/git_signing_ed25519";
          mode = "0400";
        };
      };
    };
  };
}
