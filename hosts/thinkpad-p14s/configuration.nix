{inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p14s-amd-gen6
    ./hardware-configuration.nix
    ./base.nix
    ./services.nix
  ];
}
