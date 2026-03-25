{...}: {
  flake.homeManagerModules.tmux = {...}: {
    programs.tmux = {
      enable = true;
      prefix = "`";
      shortcut = "`";
      terminal = "tmux-256color";
      historyLimit = 5000;
      mouse = true;
      keyMode = "vi";
      escapeTime = 0;
      baseIndex = 1;

      extraConfig = ''
        set -w -g xterm-keys on
        set -g allow-passthrough all
        set -as terminal-features ',*:RGB'
        set -g focus-events on

        set -g status-style 'fg=#d0d0d0,bg=#151515'
        set -g status-justify left
        set -g message-style 'fg=#d0d0d0,bg=#202020'
        set -g pane-border-style 'fg=#303030'
        set -g pane-active-border-style 'fg=#6a9fb5'
        set -g window-status-current-style 'fg=#151515,bg=#f4bf75,bold'
        set -g window-status-style 'fg=#b0b0b0,bg=#151515'
        set -g window-status-separator ""
        set -g window-status-format '   #I   '
        set -g window-status-current-format '   #I   '
        set -g status-left ""
        set -g status-right ""

        set-hook -g after-new-session 'if-shell -F "#{==:#{window_panes},1}" "split-window -h -c \"#{pane_current_path}\"; select-pane -L; resize-pane -R 15"'

        bind '"' split-window -c "#{pane_current_path}"
        bind '%' split-window -c "#{pane_current_path}" -h
        bind 'c' new-window -c "#{pane_current_path}"
      '';
    };
  };
}
