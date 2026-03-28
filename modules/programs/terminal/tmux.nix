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

        set -g status-style 'fg=default,bg=default'
        set -g status-justify left
        set -g message-style 'fg=default,bg=default'
        set -g pane-border-style 'fg=#303030'
        set -g pane-active-border-style 'fg=#6a9fb5'
        set -g window-status-current-style 'fg=default,bg=default,bold'
        set -g window-status-style 'fg=default,bg=default'
        set -g window-status-separator ' '
        set -g window-status-format '#I:#W'
        set -g window-status-current-format '#[bold]#I:#W#[nobold]'
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
