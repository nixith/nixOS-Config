if not status --is-interactive
    exit
end
set -e fish_user_paths
set -U fish_user_paths $HOME/.bin $HOME/.local/bin $HOME/Applications $fish_user_paths $HOME/.config/emacs/bin
# Sets the terminal type for proper colors
# set TERM xterm-256color

set fish_greeting

if status --is-login
    set -gx PATH $PATH ~/.bin
end

if status --is-login
    set -gx PATH $PATH ~/.local/bin
end

