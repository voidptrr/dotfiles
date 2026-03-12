{self, ...}: {
  perSystem = {pkgs, ...}: let
    tmuxBin = "${self.packages.${pkgs.stdenv.hostPlatform.system}.tmux}/bin/tmux";
  in {
    packages.ptx = pkgs.writeShellApplication {
      name = "ptx";
      runtimeInputs = with pkgs; [
        coreutils
        fzf
      ];
      text = ''
        projects_root="$HOME/git"

        if [ ! -d "$projects_root" ]; then
          echo "ptx: projects root not found: $projects_root" >&2
          exit 1
        fi

        project_path="$({
          for d in "$projects_root"/*; do
            [ -d "$d" ] || continue
            printf '%s\n' "$d"
          done
        } | fzf --height=40% --reverse --prompt='project> ')"

        [ -n "$project_path" ] || exit 0

        session_name="$(basename "$project_path" | tr ' .:' '_')"

        if "${tmuxBin}" has-session -t "$session_name" 2>/dev/null; then
          exec "${tmuxBin}" attach-session -t "$session_name"
        else
          exec "${tmuxBin}" new-session -s "$session_name" -c "$project_path"
        fi
      '';
    };
  };
}
