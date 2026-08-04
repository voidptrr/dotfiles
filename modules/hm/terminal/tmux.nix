{
  lib,
  config,
  pkgs,
  ...
}: {
  options.hm.terminal.tmux.enable = lib.mkEnableOption "tmux terminal multiplexer";

  config = lib.mkIf config.hm.terminal.tmux.enable {
    programs.tmux = {
      enable = true;
      customPaneNavigationAndResize = true;
      escapeTime = 10;
      focusEvents = true;
      historyLimit = 100000;
      keyMode = "vi";
      mouse = true;
      prefix = "C-a";
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "tmux-256color";

      extraConfig = ''
        set -ga terminal-overrides ",alacritty:Tc"
        set -ga terminal-features "*:hyperlinks"

        bind -T copy-mode-vi v send -X begin-selection
        bind -T copy-mode-vi y send-keys -X copy-pipe 'xclip -in -selection clipboard &> /dev/null'
        bind -T copy-mode-vi Enter send-keys -X cancel
        bind-key -nr C-y run "tmux show-buffer | xclip -in -selection clipboard &> /dev/null"

        set -g set-titles on
        set -g set-titles-string "#T"

        set -g status-right ""
        set -g status-right-length 0

        set-option -g status-style "fg=#c0caf5,bg=#1f2335"
        set-window-option -g window-status-style "fg=#a9b1d6,bg=default"
        set-window-option -g window-status-current-style "fg=#7aa2f7,bg=default"

        set-option -g pane-border-style "fg=#3b4261"
        set-option -g pane-active-border-style "fg=#7aa2f7"

        set-option -g message-style "fg=#c0caf5,bg=#1f2335"
        set-option -g display-panes-active-colour "#9ece6a"
        set-option -g display-panes-colour "#e0af68"
        set-window-option -g clock-mode-colour "#9ece6a"
        set-window-option -g mode-style "fg=#c0caf5,bg=#3b4261"
        set-window-option -g window-status-bell-style "fg=#1a1b26,bg=#f7768e"
      '';
    };
  };
}
