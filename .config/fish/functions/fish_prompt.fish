# You can override some default options with config.fish:
#
#  set -g theme_short_path yes
#  set -g theme_stash_indicator yes
#  set -g theme_ignore_ssh_awareness yes

function fish_prompt
    set -l last_command_status $status
    set -l cwd

    if test "$theme_short_path" = 'yes'
        set cwd (basename (prompt_pwd))
    else
        set cwd (prompt_pwd)
    end

    set -l fish     "⋊>"
    set -l ahead    "↑"
    set -l behind   "↓"
    set -l diverged "⥄"
    set -l dirty    "⨯"
    set -l stash    "≡"
    set -l none     "◦"

    set -l normal_color     (set_color normal)
    set -l success_color    (set_color cyan)
    set -l error_color      (set_color $fish_color_error 2> /dev/null; or set_color red --bold)
    set -l directory_color  (set_color $fish_color_quote 2> /dev/null; or set_color brown)
    set -l repository_color (set_color $fish_color_cwd 2> /dev/null; or set_color green)

    set -l prompt_string $fish

    if test "$theme_ignore_ssh_awareness" != 'yes' -a -n "$SSH_CLIENT$SSH_TTY"
        set prompt_string "$fish "(whoami)"@"(hostname -s)" $fish"
    end

    if test $last_command_status -eq 0
        echo -n -s $success_color $prompt_string $normal_color
    else
        echo -n -s $error_color $prompt_string $normal_color
    end

    function git_ahead -a ahead behind diverged none
        not git_is_repo; and return

        set -l commit_count (command git rev-list --count --left-right "@{upstream}...HEAD" 2> /dev/null)

        switch "$commit_count"
        case ""
            # no upstream
        case "0"\t"0"
            test -n "$none"; and echo "$none"; or echo ""
        case "*"\t"0"
            test -n "$behind"; and echo "$behind"; or echo "-"
        case "0"\t"*"
            test -n "$ahead"; and echo "$ahead"; or echo "+"
        case "*"
            test -n "$diverged"; and echo "$diverged"; or echo "±"
        end
    end

    function git_branch_name -d "Get current branch name"
        git_is_repo; and begin
            command git symbolic-ref --short HEAD 2> /dev/null;
            or command git show-ref --head -s --abbrev | head -n1 2> /dev/null
        end
    end

    function git_is_repo -d "Check if directory is a repository"
        test -d .git
        or begin
            set -l info (command git rev-parse --git-dir --is-bare-repository 2>/dev/null)
            and test $info[2] = false
        end
    end

    function git_is_stashed -d "Check if repo has stashed contents"
        git_is_repo; and begin
            command git rev-parse --verify --quiet refs/stash >/dev/null
        end
    end

    function git_is_touched -d "Check if repo has any changes"
        git_is_worktree; and begin
            # The first checks for staged changes, the second for unstaged ones.
            # We put them in this order because checking staged changes is *fast*.  
            not command git diff-index --cached --quiet HEAD -- >/dev/null 2>&1
            or not command git diff --no-ext-diff --quiet --exit-code >/dev/null 2>&1
        end
    end

    function git_is_worktree -d "Check if directory is inside the worktree of a repository"
        git_is_repo
        and test (command git rev-parse --is-inside-git-dir) = false
    end

    if git_is_repo
        if test "$theme_short_path" = 'yes'
        set root_folder (command git rev-parse --show-toplevel 2> /dev/null)
        set parent_root_folder (dirname $root_folder)
        set cwd (echo $PWD | sed -e "s|$parent_root_folder/||")
        end

        echo -n -s " " $directory_color $cwd $normal_color
        echo -n -s " on " $repository_color (git_branch_name) $normal_color " "


        set -l list
        if test "$theme_stash_indicator" = yes; and git_is_stashed
        set list $list $stash
        end
        if git_is_touched
        set list $list $dirty
        end
        echo -n $list

        if test -z "$list"
        echo -n -s (git_ahead $ahead $behind $diverged $none)
        end
    else
        echo -n -s " " $directory_color $cwd $normal_color
    end

    echo -n -s " "
end
