{lib, ...}: {
  flake.homeManagerModules.shells-shared = {pkgs, ...}: {
    options.programs.shellProfile = {
      environmentVariables = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = {};
      };

      shellAliases = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = {};
      };
    };

    config = {
      programs.shellProfile.environmentVariables = {
        EDITOR = lib.mkDefault "nvim";
        BROWSER = lib.mkDefault "firefox";
        TERMINAL = lib.mkDefault "ghostty";
      };

      programs.shellProfile.shellAliases = {
        ll = lib.mkDefault "ls -la";
        rebuild = lib.mkDefault (
          if pkgs.stdenv.hostPlatform.isDarwin
          then "sudo darwin-rebuild switch --flake ~/git/dotfiles#personal"
          else "sudo nixos-rebuild switch"
        );
      };
    };
  };
}
