{...}: {
  perSystem = {pkgs, ...}: {
    packages.zsh-wrapped = let
      zshDotDir = toString (
        pkgs.linkFarm "zsh-merged-config" [
          {
            name = ".zshrc";
            path = ./zshrc;
          }
          {
            name = ".zshenv";
            path = ./zshenv;
          }
        ]
      );
    in
      pkgs.symlinkJoin {
        name = "zsh-wrapped";
        paths = [pkgs.zsh];
        buildInputs = [pkgs.makeWrapper];
        postBuild = ''
          wrapProgram "$out/bin/zsh" --set ZDOTDIR "${zshDotDir}"
        '';
      };
  };
}
