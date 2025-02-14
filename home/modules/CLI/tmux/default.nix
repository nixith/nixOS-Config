{ pkgs, ... }: {
  programs.tmux = {
    aggressiveResize = true;
    clock24 = true;
    enable = true;
    mouse = true;
    keyMode = "vi";
    newSession = true;
    plugins = with pkgs; [ tmuxPlugins.better-mouse-mode tmuxPlugins.tmux-fzf ];
    shortcut = "s";
    extraConfig = # tmux
      ''
        set -g history-limit 50000

        # Increase tmux messages display duration from 750ms to 4s
        set -g display-time 4000

        # Refresh 'status-left' and 'status-right' more often, from every 15s to 5s
        set -g status-interval 5

        set -g extended-keys on # ctrl and shift binds
        set -g allow-passthrough all 

        #Control + Space keybind
        unbind C-Space
        set -g prefix C-Space
        bind C-Space send-prefix

        # quick vertical split
        bind-key v split-window -h  #split is horizontal, window is vertical

        # quick horizontal split 
        bind-key h split-window -v

        set-option -g allow-passthrough all
      '';
  };
  programs.fzf.tmux.enableShellIntegration = true;
}
