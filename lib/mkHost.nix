{inputs}: {
  hostname,
  username,
  hostDirectory,
  system,
}: let
  hostConfiguration = ../hosts + "/${hostDirectory}/configuration.nix";
  hostHomeConfiguration = ../hosts + "/${hostDirectory}/config.nix";
in {
  nixosConfigurations.${hostname} = inputs.nixpkgs.lib.nixosSystem {
    inherit system;

    specialArgs = {
      inherit inputs hostname username;
    };

    modules = [
      (import ./nix-config.nix)
      inputs.home-manager.nixosModules.home-manager
      hostConfiguration

      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
          extraSpecialArgs = {
            inherit inputs hostname username;
          };

          users.${username}.imports = [
            ../home/default.nix
            hostHomeConfiguration
          ];
        };
      }
    ];
  };
}
