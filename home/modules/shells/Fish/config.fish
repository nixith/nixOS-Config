if not status --is-interactive
    exit
end
set -e fish_user_paths
set -U fish_user_paths $HOME/.bin $HOME/.local/bin $HOME/Applications $fish_user_paths $HOME/.config/emacs/bin
# Sets the terminal type for proper colors
set TERM xterm-256color

set fish_greeting

# Prevent directories names from being shortened
set fish_prompt_pwd_dir_length 0
set -x FZF_DEFAULT_OPTS "--color=16,header:13,info:5,pointer:3,marker:9,spinner:1,prompt:5,fg:7,hl:14,fg+:3,hl+:9 --inline-info --tiebreak=end,length --bind=shift-tab:toggle-down,tab:toggle-up"
# "bat" as manpager
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -g theme_nerd_fonts yes


if status --is-login
    set -gx PATH $PATH ~/.bin
end

if status --is-login
    set -gx PATH $PATH ~/.local/bin
end

if type -q bat
    alias cat="bat -p --paging=never"
end


if type -q direnv
    eval (direnv hook fish)
end

### FUNCTIONS ###
# Fish command history
function gl
    git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" $argv | sk --ansi --no-sort --reverse --tiebreak=index --toggle-sort=\` --bind "ctrl-m:execute: echo '{}' | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always % | less -R'"
end

function ex --description "Extract bundled & compressed files"
    if test -f "$argv[1]"
        switch $argv[1]
            case '*.tar.bz2'
                tar xjf $argv[1]
            case '*.tar.gz'
                tar xzf $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.rar'
                unrar $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.tar'
                tar xf $argv[1]
            case '*.tbz2'
                tar xjf $argv[1]
            case '*.tgz'
                tar xzf $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.Z'
                uncompress $argv[1]
            case '*.7z'
                7z $argv[1]
            case '*.deb'
                ar $argv[1]
            case '*.tar.xz'
                tar xf $argv[1]
            case '*.tar.zst'
                tar xf $argv[1]
            case '*'
                echo "'$argv[1]' cannot be extracted via ex"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end

function cd
    builtin cd $argv; and ls
end

### ALIASES ###




#add new fonts
# reporting tools - install when not installed
# neofetch
#screenfetch
#alsi
#paleofetch
#fetch
#hfetch
#sfetch
#ufetch
#ufetch-arco | lolcat
#pfetch
#sysinfo
#sysinfo-retro
#cpufetch
#colorscript random

# colors to set or unset
# name: 'Catppuccin mocha'
# url: 'https://github.com/catppuccin/fish'
# preferred_background: 1e1e2e

set fish_color_normal "#cdd6f4"
set fish_color_command "#89b4fa"
set fish_color_param "#f2cdcd"
set fish_color_keyword "#f38ba8"
set fish_color_quote "#a6e3a1"
set fish_color_redirection "#f5c2e7"
set fish_color_end "#fab387"
set fish_color_comment "#7f849c"
set fish_color_error "#f38ba8"
set fish_color_gray "#6c7086"
set fish_color_selection "--background=313244"
set fish_color_search_match "--background=313244"
set fish_color_option "#a6e3a1"
set fish_color_operator "#f5c2e7"
set fish_color_escape "#eba0ac"
set fish_color_autosuggestion "#6c7086"
set fish_color_cancel "#f38ba8"
set fish_color_cwd "#f9e2af"
set fish_color_user "#94e2d5"
set fish_color_host "#89b4fa"
set fish_color_host_remote "#a6e3a1"
set fish_color_status "#f38ba8"
set fish_pager_color_progress "#6c7086"
set fish_pager_color_prefix "#f5c2e7"
set fish_pager_color_completion "#cdd6f4"
set fish_pager_color_description "#6c7086"
