{config, ...}: {
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;
      folding.enable = true;

      grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
        rust
        nix
        c
      ];
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
    };
  };
}
