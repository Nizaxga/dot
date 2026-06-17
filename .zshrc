# Install fzf + yazi + bat + lazygit
export MANPAGER="nvim +Man!"
export EDITOR='nvim'
# ALIAS
alias vim=nvim
alias ll="ls -lah --color=auto"
alias du="du -ch -d 1"
alias l="tree -aph -L 2"
alias lg=lazygit
alias cat="bat -p"
alias :q="exit"

# Python venv
ve() {
    if ! source .venv/bin/activate &>/dev/null; then
        echo "No .venv found, Create one..."
        python3 -m venv .venv
        source .venv/bin/activate
    fi
}
alias de="deactivate"

# SCRIPTS
alias fsort="~/.dotfiles/Scripts/fsort.sh"
alias clip="~/.dotfiles/Scripts/copy-file.sh"
alias prime="~/.dotfiles/Scripts/primes.out"

# fzf
eval "$(fzf --zsh)"

_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    vim)
      fzf --preview 'bat -n --color=always --line-range :500 {}' \
          --preview-window wrap-word "$@"
      ;;
    vi)
      fzf --preview 'bat -n --color=always --line-range :500 {}' "$@"
      ;;
    *)
      fzf "$@"
      ;;
  esac
}

# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

