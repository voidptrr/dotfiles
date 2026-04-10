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
    mkHost = import ./lib/mkHost.nix {inherit inputs;};
    host = mkHost {
      hostname = "jett";
      username = "voidptr";
      hostDirectory = "thinkpad-p14s";
      system = "x86_64-linux";
    };
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  in {
    lib.mkHost = mkHost;

    inherit (host) nixosConfigurations;

    formatter.x86_64-linux = pkgs.alejandra;

    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = with pkgs; [
        nil
        stylua
        lua-language-server
      ];
    };

    checks.x86_64-linux.formatting = pkgs.runCommand "checks" {} ''
      cd ${./.}
      ${pkgs.alejandra}/bin/alejandra --check .
      ${pkgs.stylua}/bin/stylua --check config/nvim
      touch "$out"
    '';
  };
}
