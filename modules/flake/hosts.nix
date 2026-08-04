{
  self,
  inputs,
  lib,
  ...
}: let
  nixosModules =
    [
      inputs.home-manager.nixosModules.home-manager
    ]
    ++ builtins.attrValues self.nixosModules;

  loadNixOS = hostname: path: {
    path = builtins.dirOf path;
    class = "nixos";
    value = inputs.nixpkgs.lib.nixosSystem {
      modules =
        [
          path
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = {
                inherit self inputs hostname;
              };
            };
          }
        ]
        ++ nixosModules;

      specialArgs = {
        inherit inputs self hostname;
      };
    };
  };

  loadHost = hostname: path:
    if builtins.pathExists (path + "/configuration.nix")
    then loadNixOS hostname (path + "/configuration.nix")
    else throw "host '${hostname}' does not have a configuration.nix";

  hosts = lib.mapAttrs loadHost (self.lib.fs.scanAttrs ../../hosts);
in {
  flake = {
    homeModules = {
      default = ../home;
    };

    nixosModules = {
      default = ../nixos;
      snippets = ../snippets;
    };

    nixosConfigurations = lib.mapAttrs (_: host: host.value) hosts;
  };
}
