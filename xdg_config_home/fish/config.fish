
if status is-interactive
    # Commands to run in interactive sessions can go here
    if test -f /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)

	fish_add_path "/opt/homebrew/opt/postgresql@16/bin"
	fish_add_path "$HOME/.krew/bin"
    end

    if test -f ~/.rbenv/bin/rbenv
        ~/.rbenv/bin/rbenv init - fish | source
    end

    fish_add_path "$HOME/.cargo/bin"

    set -g SHELL $(which fish)
end

abbr -a gaa git add --all
abbr -a gau git add --update
abbr -a gcb git checkout -b
abbr -a gcm git switch main
abbr -a gco git checkout
abbr -a gd git diff
abbr -a gds git diff --staged
abbr -a gfo git fetch origin
abbr -a gl git pull
abbr -a gp git push
abbr -a grba git rebase --abort
abbr -a grbc git rebase --continue
abbr -a grbm git rebase main
abbr -a gsh git show
abbr -a gst git status
abbr -a gsw git switch
