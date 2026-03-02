{pkgs, ...}: {
  plugins.treesitter = {
    enable = true;
    highlight.enable = true;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      nix
      yaml
      rust
      c
      typescript
    ];
  };
}
