if not status --is-interactive
    exit
end
set -e fish_user_paths
set -U fish_user_paths $HOME/.bin $HOME/.local/bin $HOME/Applications $fish_user_paths $HOME/.config/emacs/bin
# Sets the terminal type for proper colors
# set TERM xterm-256color

set fish_greeting

# Prevent directories names from being shortened
set fish_prompt_pwd_dir_length 0
# "bat" as manpager
set -x MANROFFOPT '-c'
set -x MANPAGER "sh -c 'col -b | bat -p -l man'"
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
    git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" $argv | fzf --ansi --no-sort --reverse --tiebreak=index --toggle-sort=\` --bind "ctrl-m:execute: echo '{}' | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always % | less -R'"
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

#export LS_COLORS="$(vivid generate catppuccin-mocha)"

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
