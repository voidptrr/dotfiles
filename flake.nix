{
  description = "Systems' configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
  };

  outputs = inputs: let
    systemLib = import ./lib/system.nix {inherit inputs;};
  in {
    inherit
      (systemLib.mkLinuxSystem {
        hostname = "jett";
        username = "voidptr";
        hostDirectory = "thinkpad-p14s";
        system = systemLib.systemMap.linux;
      })
      nixosConfigurations
      ;

    formatter = systemLib.forEachSystem ({pkgs, ...}: pkgs.alejandra);

    devShells = systemLib.forEachSystem ({pkgs, ...}: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          nil
          stylua
          lua-language-server
        ];
      };
    });

    checks = systemLib.forEachSystem ({pkgs, ...}: {
      formatting = pkgs.runCommand "checks" {} ''
        cd ${./.}
        ${pkgs.alejandra}/bin/alejandra --check .
        ${pkgs.stylua}/bin/stylua --check config/nvim
        touch "$out"
      '';
    });
  };
}
