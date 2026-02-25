{...}: {
  flake.homeManagerModules.tmux = {pkgs, ...}: {
    programs.tmux = {
      enable = true;
      prefix = "C-a";
      terminal = "screen-256color";
      focusEvents = true;
      historyLimit = 5000;
      mouse = true;
      keyMode = "vi";
      escapeTime = 0;
      shell = "${pkgs.zsh}/bin/zsh";
      plugins = [
        {
          plugin = pkgs.tmuxPlugins.gruvbox;
          extraConfig = "set -g @tmux-gruvbox 'dark'";
        }
        {
          plugin = pkgs.tmuxPlugins.prefix-highlight;
          extraConfig = ''
            set -g @prefix_highlight_show_copy_mode 'on'
            set -g @prefix_highlight_copy_mode_attr 'fg=black,bg=yellow,bold'
            set -g @prefix_highlight_show_sync_mode 'on'
            set -g @prefix_highlight_sync_mode_attr 'fg=black,bg=green'
          '';
        }
        {
          plugin = pkgs.tmuxPlugins.fzf-tmux-url;
        }
      ];
      extraConfig = ''
        bind '"' split-window -c "#{pane_current_path}"
        bind '%' split-window -c "#{pane_current_path}" -h
        bind 'c' new-window -c "#{pane_current_path}"

        bind -r h resize-pane -L 5
        bind -r j resize-pane -D 5
        bind -r k resize-pane -U 5
        bind -r l resize-pane -R 5

        bind R source-file ~/.config/tmux/tmux.conf
      '';
    };
  };
}
