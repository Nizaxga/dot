# Needed fd,rg,fzf,bat,lazygit
export MANPAGER="nvim +Man!"
export EDITOR='nvim'
export VISUAL='nvim'

# ALIAS
alias vim=nvim
alias ll="ls -lah --color=auto"
alias du="du -ch -d 1"
alias l="tree -aph -L 2"
alias lg=lazygit
alias cat="bat -p"
alias :q="exit"

eval "$(fzf --zsh)"

# Python venv
ve() {
    if ! . .venv/bin/activate &>/dev/null; then
        echo "No .venv found, Create one..."
        python3 -m venv .venv
        . .venv/bin/activate
    fi
}
alias de="deactivate"

# SCRIPTS
alias fsort="~/.dot/Scripts/fsort.sh"
alias clip="~/.dot/Scripts/copy-file.sh"
alias prime="~/.dot/Scripts/primes.out"
