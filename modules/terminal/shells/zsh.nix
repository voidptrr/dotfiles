{...}: {
  flake.homeManagerModules.zsh = {
    pkgs,
    lib,
    ...
  }: {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      sessionVariables = {
        EDITOR = "nvim";
        BROWSER = "firefox";
        TERMINAL = "ghostty";
      };
      shellAliases = {
        ls = "ls -al";
        nd = "nix develop -c zsh";
        rebuild =
          if pkgs.stdenv.hostPlatform.isDarwin
          then "sudo darwin-rebuild switch"
          else "sudo nixos-rebuild switch";
      };

      initContent = lib.mkOrder 500 ''
        autoload -Uz vcs_info
        zstyle ':vcs_info:git:*' formats '%F{red}[%b]%f'

        export LESS_TERMCAP_mb="$(printf '%b' '\e[1;32m')"
        export LESS_TERMCAP_md="$(printf '%b' '\e[1;32m')"
        export LESS_TERMCAP_me="$(printf '%b' '\e[0m')"
        export LESS_TERMCAP_se="$(printf '%b' '\e[0m')"
        export LESS_TERMCAP_so="$(printf '%b' '\e[01;33m')"
        export LESS_TERMCAP_ue="$(printf '%b' '\e[0m')"
        export LESS_TERMCAP_us="$(printf '%b' '\e[1;4;31m')"
        export LESS_TERMCAP_mr="$(tput rev)"
        export LESS_TERMCAP_mh="$(tput dim)"
        export LESS_TERMCAP_ZN="$(tput ssubm)"
        export LESS_TERMCAP_ZV="$(tput rsubm)"
        export LESS_TERMCAP_ZO="$(tput ssupm)"
        export LESS_TERMCAP_ZW="$(tput rsupm)"

        precmd() {
          vcs_info
          if [ -n "''${IN_NIX_SHELL-}" ]; then
            PROMPT="%F{red}%n%f in %F{yellow}%~%f %F{red}''${vcs_info_msg_0_}%f%F{blue}[nix]%f %# "
          else
            PROMPT="%F{red}%n%f in %F{yellow}%~%f %F{red}''${vcs_info_msg_0_}%f %# "
          fi
        }
      '';
    };
  };
}
