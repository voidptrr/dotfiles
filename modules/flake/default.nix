{lib, ...}: {
  imports = with lib;
    map (name: ./${name})
    (builtins.attrNames (
      filterAttrs (
        name: _:
          !(hasPrefix "_" name)
          && !(hasPrefix "default" name)
      ) (builtins.readDir ./.)
    ));

  flake = {
    root = ../..;
    secretsDir = ../../secrets;
  };
}
