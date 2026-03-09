{pkgs, ...}: {
  plugins.treesitter = {
    enable = true;
    highlight.enable = true;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      # System configuration
      nix
      yaml

      # Shell scripting 
      bash
      nu

      # Systems languages
      c
      rust
      zig

      # Web scripting 
      typescript
    ];
  };
}
