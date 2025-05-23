if status is-interactive
    # Commands to run in interactive sessions can go here
    source $HOME/.env

    function fish_greeting
    end

    abbr --add vim nvim
    abbr --add vi nvim

    abbr --add cat bat
    abbr --add ls lsd
    abbr --add lg lazygit

    set -x EDITOR nvim

    alias vimf='nvim $(fzf)'
    alias tmuxf='tmux attach-session -t $(tmux list-session | fzf | cut -d ":" -f 1)'
end

