{
  description = "System configuration infrastructure for my machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    import-tree.url = "github:vic/import-tree";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {...} @ inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;}
    {
      imports = [
        (inputs.import-tree ./modules)
      ];

      systems = ["aarch64-darwin"];
      perSystem = {pkgs, ...}: {
        formatter = pkgs.alejandra;
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            # secrets
            age
            sops

            # nvim
            nil
            stylua
            lua-language-server
          ];

          shellHook = ''
            export SOPS_AGE_KEY_FILE="$HOME/sops/age/keys.txt"
          '';
        };
        checks = {
          checks = pkgs.runCommand "checks" {} ''
            cd ${./.}
            ${pkgs.alejandra}/bin/alejandra --check .
            ${pkgs.stylua}/bin/stylua --check config/nvim
            touch $out
          '';
        };
      };
    };
}
