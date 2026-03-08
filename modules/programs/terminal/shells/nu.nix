{...}: {
  flake.homeManagerModules.nu = {config, ...}: let
    cfg = config.programs.shellProfile;
  in {
    programs.nushell = {
      enable = true;

      shellAliases =
        cfg.shellAliases
        // {
          nd = "nix develop -c nu";
        };

      environmentVariables = cfg.environmentVariables;

      extraEnv = ''
        let current_path = (
          if ($env.PATH | describe | str starts-with "list") {
            $env.PATH
          } else {
            $env.PATH | split row (char esep)
          }
        )

        $env.PATH = (
          $current_path
          | prepend $"/etc/profiles/per-user/($env.USER)/bin"
          | prepend "/run/current-system/sw/bin"
          | prepend $"($env.HOME)/.nix-profile/bin"
          | prepend "/nix/var/nix/profiles/default/bin"
          | uniq
        )
      '';

      settings = {
        show_banner = false;
        completions = {
          external.enable = false;
        };
        color_config = {
          shape_external = "white";
        };
        cursor_shape = {
          emacs = "line";
          vi_insert = "line";
          vi_normal = "line";
        };
      };

      extraConfig = ''
        $env.config.menus = []
        $env.PROMPT_COMMAND_RIGHT = ""
        $env.PROMPT_INDICATOR = " % "
        $env.PROMPT_INDICATOR_VI_INSERT = " % "
        $env.PROMPT_INDICATOR_VI_NORMAL = " % "
        $env.PROMPT_MULTILINE_INDICATOR = "::: "
        $env.PROMPT_COMMAND = {||
          let branch = (do -i { ^git rev-parse --abbrev-ref HEAD err> /dev/null | str trim })
          let in_nix = ($env | columns | any {|it| $it == "IN_NIX_SHELL" })
          let cwd = (pwd)
          let cwd_short = if ($cwd | str starts-with $env.HOME) {
            $cwd | str replace $env.HOME "~"
          } else {
            $cwd
          }
          let path_part = $"(ansi yellow)($cwd_short)(ansi reset)"
          let branch_part = if ($branch | is-empty) {
            ""
          } else {
            $" (ansi dark_gray)*($branch)(ansi reset)"
          }
          let nix_part = if $in_nix {
            $" (ansi blue_dimmed)" + "(nix)" + $"(ansi reset)"
          } else {
            ""
          }

          $"($path_part)($branch_part)($nix_part)"
        }
      '';
    };
  };
}
