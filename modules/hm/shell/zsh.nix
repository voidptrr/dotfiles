{
  hostname,
  lib,
  config,
  pkgs,
  ...
}: {
  options.hm.shell.zsh.enable = lib.mkEnableOption "zsh";

  config = lib.mkIf config.hm.shell.zsh.enable {
    home.packages = [
      pkgs.stylua
    ];

    programs.zsh = {
      enable = true;

      shellAliases = {
        vi = "nvim";
        vim = "nvim";
        ll = "ls -la";
        nd = "nix develop -c \"$SHELL\"";
        rebuild = "sudo nixos-rebuild switch --flake ~/git/dotfiles#${hostname}";
      };

      sessionVariables = {
        EDITOR = "nvim";
        BROWSER = "firefox";
        TERMINAL = "alacritty";
      };

      initContent = ''
          autoload -Uz vcs_info
          zstyle ':vcs_info:git:*' formats '*%b'

          precmd() {
            vcs_info

            local nix_part=""
            if [ -n "''${IN_NIX_SHELL-}" ]; then
              nix_part="%F{yellow}(nix)%f"
            fi

            PROMPT="%F{yellow}%~%f"

            if [ -n "''${vcs_info_msg_0_-}" ]; then
              PROMPT+=" %F{red}''${vcs_info_msg_0_-}%f"
            fi

            if [ -n "$nix_part" ]; then
              PROMPT+=" $nix_part"
            fi

          PROMPT+=" %F{red}%%%f "
        }
      '';
    };
  };
}
