if status is-interactive
    # Commands to run in interactive sessions can go here
end


abbr --add vim nvim
abbr --add vi nvim

abbr --add cat bat
abbr --add ls lsd
abbr --add lgit lazygit

alias vimf='nvim $(fzf)'

function fm  -d "Open File Manager(Yazi)"
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end
