{lib}: let
  isImportable = name: type:
    !(lib.hasPrefix "_" name)
    && (
      type
      == "directory"
      || (name != "default.nix" && lib.hasSuffix ".nix" name)
    );

  toAttrName = name:
    if lib.hasSuffix ".nix" name
    then lib.removeSuffix ".nix" name
    else name;
in {
  scanPaths = path:
    map (name: path + "/${name}") (
      builtins.attrNames (
        lib.filterAttrs isImportable (builtins.readDir path)
      )
    );

  scanAttrs = path: let
    entries = lib.filterAttrs isImportable (builtins.readDir path);
  in
    lib.mapAttrs' (name: _: {
      name = toAttrName name;
      value = path + "/${name}";
    })
    entries;
}
