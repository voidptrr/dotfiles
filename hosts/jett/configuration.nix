{inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p14s-amd-gen6
    ./hardware-configuration.nix
    ./base.nix
    ./home.nix
  ];

  my.nixos = {
    base.enable = true;

    desktop = {
      xserver.enable = true;
      i3 = {
        enable = true;
        usei3Status = true;
      };
    };

    programs.nix.enable = true;

    services = {
      ly.enable = true;
    };
  };
}
