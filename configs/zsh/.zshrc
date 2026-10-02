#Homebrew
export PATH="/opt/homebrew/bin:$PATH"

# jEnv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# Zsh Utils 
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# File Colors
export CLICOLOR=1
alias ls='ls -G'

# Starship
eval "$(starship init zsh)"

# Fastfetch - ricingggggg XD 
if [[ $- == *i* ]] && command -v fastfetch >/dev/null 2>&1; then
  fastfetch
fi

# Delete Duplicated PATHs
typeset -U path PATH

# pmset customised
# Keep the Mac awake even with the lid closed or on battery.
# Holds the terminal until it ends, then restores sleep.
# Usage
#   `awake` - last for 8hours (Ctrl+C to stop early)
#   `awake 10` - last for 10hours
#   `awake off` - restore sleep by hand (after a crash or kill -9)
awake() {
  if [[ $1 == off ]]; then
    sudo pmset -a disablesleep 0 && echo "Sleep restored."
    return
  fi
  local h=${1:-8} s=s
  if [[ $h != <1-> ]]; then
    echo "usage: awake [hours|off]" >&2
    return 1
  fi
  [[ $h == 1 ]] && s=
  sudo sh -c '
    trap "" PIPE TSTP
    trap : INT TERM HUP QUIT
    if pmset -a disablesleep 1; then
      echo "Mac will not sleep for $2. (Ctrl+C to stop)"
      caffeinate -dimsu -t "$1" &
      wait $!
    fi
    trap "" INT TERM HUP QUIT
    { kill -9 $!; wait $!; } 2>/dev/null
    pmset -a disablesleep 0 && echo "Sleep restored."
  ' sh $((h*3600)) "$h hour$s"
}
