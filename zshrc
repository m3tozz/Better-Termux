# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
source /data/data/com.termux/files/home/.zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /data/data/com.termux/files/home/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fpath=(/data/data/com.termux/files/home/.zsh/plugins/zsh-completions/src $fpath)

# cd && ls
cd() {
  if [ $# -eq 0 ]; then
    builtin cd ~ || return
  else
    builtin cd "$@" || return
  fi
  ls
}

# BetterTermux Updater
bettertermux_updater() {
  bettertermux_path="$HOME/.bettertermux/Better-Termux/better-termux.sh"

  if [ -f "$bettertermux_path" ]; then
    remote_ver=$(curl -s https://raw.githubusercontent.com/m3tozz/Better-Termux/main/better-termux.sh | grep -E "^ *version=" | cut -d"'" -f2)
    local_ver=$(grep -E "^ *version=" "$bettertermux_path" | cut -d"'" -f2)

    if [ "$remote_ver" != "$local_ver" ]; then
      echo -e "\e[1;32mBetterTermux update found: $local_ver → $remote_ver\e[0m"
      echo "Updating..."
      bash "$bettertermux_path" --install
      cd
      export BETTERTERMUX_UPDATED=1
      return 0
    fi
  fi
  return 1
}

if [ -z "$BETTERTERMUX_UPDATED" ]; then
  bettertermux_updater
fi

bettertermux_updater
neofetch
