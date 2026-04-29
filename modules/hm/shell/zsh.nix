{
  hostname,
  lib,
  config,
  ...
}: {
  options.hm.shell.zsh.enable = lib.mkEnableOption "zsh";

  config = lib.mkIf config.hm.shell.zsh.enable {
    programs.zsh = {
      enable = true;

      shellAliases = {
        ll = "ls -la";
        nd = "nix develop -c \"$SHELL\"";
        rebuild = "sudo nixos-rebuild switch --flake ~/git/dotfiles#${hostname}";
      };

      sessionVariables = {
        EDITOR = "vim";
        BROWSER = "firefox";
        TERMINAL = "ghostty";
      };

      initContent = ''
          autoload -Uz vcs_info
          zstyle ':vcs_info:git:*' formats '*%b'

          precmd() {
            vcs_info

            local nix_part=""
            if [ -n "''${IN_NIX_SHELL-}" ]; then
              nix_part="%F{4}(nix)%f"
            fi

            PROMPT="%F{yellow}%~%f"

            if [ -n "''${vcs_info_msg_0_-}" ]; then
              PROMPT+=" %F{242}''${vcs_info_msg_0_-}%f"
            fi

            if [ -n "$nix_part" ]; then
              PROMPT+=" $nix_part"
            fi

          PROMPT+=" %% "
        }
      '';
    };
  };
}
