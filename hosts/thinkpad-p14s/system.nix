{inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p14s-amd-gen6
    ./hardware-configuration.nix
    ./base.nix
  ];

  nixos = {
    displayServer.xserver.enable = true;
    displayManager.ly.enable = true;
    theme = {
      enable = true;
      name = "kanagawa";
      variant = "dragon";
    };

    windowManager.i3 = {
      enable = true;
      usei3Status = true;
    };
  };
}
