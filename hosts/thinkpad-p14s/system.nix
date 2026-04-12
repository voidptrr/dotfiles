{inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p14s-amd-gen6
    ./hardware-configuration.nix
    ./base.nix
  ];

  nixos = {
    displayServer.xserver.enable = true;
    windowManager.i3 = {
      enable = true;
      usei3Status = true;
    };

    displayManager.ly.enable = true;
  };
}
