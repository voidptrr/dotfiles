{inputs}: let
  systemMap = {
    linux = "x86_64-linux";
  };

  systems = builtins.attrValues systemMap;

  forEachSystem = f:
    inputs.nixpkgs.lib.genAttrs systems (
      system:
        f {
          inherit system;
          pkgs = inputs.nixpkgs.legacyPackages.${system};
        }
    );
in {
  mkLinuxSystem = {
    hostname,
    username,
    hostDirectory,
    system,
  }: let
    hostConfiguration = ../hosts + "/${hostDirectory}/system.nix";
    hostHomeConfiguration = ../hosts + "/${hostDirectory}/hm.nix";
    nixConfig = {
      nix = {
        settings = {
          auto-optimise-store = true;
          warn-dirty = false;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
        };

        gc = {
          automatic = true;
          dates = "Sun 10:00";
          options = "--delete-older-than 2d";
        };
      };
    };
  in {
    nixosConfigurations.${hostname} = inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs hostname username;
      };

      modules = [
        nixConfig
        ../modules/nixos
        hostConfiguration
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            extraSpecialArgs = {
              inherit inputs hostname username;
            };

            users.${username}.imports = [
              {
                imports = [../modules/hm];
                home = {
                  inherit username;
                  homeDirectory = "/home/${username}";
                  stateVersion = "26.05";
                };

                programs.home-manager.enable = true;
              }
              hostHomeConfiguration
            ];
          };
        }
      ];
    };
  };

  inherit
    forEachSystem
    systemMap
    systems
    ;
}
