if status is-interactive
    # Commands to run in interactive sessions can go here
    eval (/opt/homebrew/bin/brew shellenv)

    fish_add_path "$HOME/.cargo/bin"
end
