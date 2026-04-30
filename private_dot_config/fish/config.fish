if status is-interactive
    # Commands to run in interactive sessions can go here
    source $HOME/.env

    function fish_greeting
    end

    abbr --add vim nvim
    abbr --add vi nvim

    abbr --add lg lazygit

    abbr --add dot chezmoi

    set -x EDITOR nvim

    alias vimf='nvim $(fzf)'
    alias tmuxf='tmux attach-session -t $(tmux list-session | fzf | cut -d ":" -f 1)'
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
