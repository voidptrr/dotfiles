{
  self,
  inputs,
  ...
}: let
  mkLinuxSystem = import ../../../lib/mkLinuxSystem.nix {
    inherit self inputs;
  };

  system = "x86_64-linux";
in {
  flake.nixosConfigurations.jett = mkLinuxSystem {
    inherit system;
    configuration = ./configuration.nix;
    hardwareModules = [
      inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p14s-amd-gen6
    ];
  };
}
