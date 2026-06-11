{
  lib,
  config,
  ...
}: let
  cfg = config.hm.dev.vim;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim.plugins.treesitter = {
      enable = true;
      highlight.enable = true;
      grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
        rust
        cpp
        zig
        json
        typescript
      ];
    };
  };
}
