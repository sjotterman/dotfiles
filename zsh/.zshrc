# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# PATH=$PATH:~/.composer/vendor/bin
PATH=$PATH:$HOME/Library/Python/3.7/bin
export PATH=$PATH:~/Library/flutter/bin
export PATH=$PATH:~/bin
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH


export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$HOME/.emacs.d/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/go/bin

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export VIRTUALENVWRAPPER_PYTHON=/opt/homebrew/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=~/.local/bin/virtualenv
source /opt/homebrew/bin/virtualenvwrapper.sh

# https://superuser.com/questions/602882/how-to-make-zsh-completion-like-bash
setopt AUTO_LIST NO_MENUCOMPLETE

# This is only needed explicitly because of an issue with the gh-prs extension
# https://github.com/dlvhdr/gh-prs/issues/82
# once this issue is closed, this line can be deleted
export XDG_CONFIG_HOME="$HOME/.config"


# ohmyzsh plugins
# plugins=(git npm zsh-autosuggestions z command-not-found react-native golang gh)


# First install zgenom:
# git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
# load zgenom
source "${HOME}/.zgenom/zgenom.zsh"

# Check for plugin and zgenom updates every 7 days
# This does not increase the startup time.
zgenom autoupdate

# to update all plugins and reset
# zgenom update

# if the init script doesn't exist
if ! zgenom saved; then

  # specify plugins here
  zgenom ohmyzsh

  zgenom ohmyzsh plugins/git
  zgenom ohmyzsh plugins/npm
  zgenom ohmyzsh plugins/z
  zgenom ohmyzsh plugins/command-not-found
  zgenom ohmyzsh plugins/react-native
  zgenom ohmyzsh plugins/golang
  zgenom ohmyzsh plugins/gh

  # zgenom load djui/alias-tips
  zgenom load z-shell/zsh-diff-so-fancy

  # completions
  zgenom load zsh-users/zsh-completions
  zgenom load zsh-users/zsh-autosuggestions

   # Install ohmyzsh osx plugin if on macOS
  [[ "$(uname -s)" = Darwin ]] && zgenom ohmyzsh plugins/macos

  # generate the init script from plugins above
  zgenom save
fi

alias vim="nvim"

export EDITOR="nvim"
export VISUAL="nvim"

alias upgrade-cask="brew cu"


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi
# Git aliases from Sky Eckstrom

alias cleangit="git fetch --all && git remote prune \$(git remote | tr \"\\n\" \" \") && git gc --prune=now && git repack -a -d --depth=250 --window=250"
alias cleanlocal="git branch --merged | grep -v '^* main$' | grep -v '^  main$' | xargs git branch -d"
alias cleanremote="git branch -r --merged origin/main | grep origin | grep -v '>' | grep -v main | xargs -L1 | awk '{split(\$0,a,\"/\"); print a[2]}' | xargs git push origin --delete"
alias cleanmerged="cleangit && cleanlocal && cleanremote"
alias cleangit-master="git fetch --all && git remote prune \$(git remote | tr \"\\n\" \" \") && git gc --prune=now && git repack -a -d --depth=250 --window=250"
alias cleanlocal-master="git branch --merged | grep -v '^* master$' | grep -v '^  master$' | xargs git branch -d"
alias cleanremote-master="git branch -r --merged origin/master | grep origin | grep -v '>' | grep -v master | xargs -L1 | awk '{split(\$0,a,\"/\"); print a[2]}' | xargs git push origin --delete"
alias cleanmerged-master="cleangit && cleanlocal && cleanremote"
alias codeup='git checkout master && git pull upstream master && git push origin master && git clean -xfd'
alias react-native-reset-button='git clean -xfd; yarn cache clean; watchman watch-del-all; '
alias b='gh branch'

# https://dave.cheney.net/2019/05/07/prefer-table-driven-tests#:~:text=packages%20to%20test.-,Spray,-some%20.bashrc%20on
go-test-cover () {
    local t=$(mktemp -t cover)
    go test $COVERFLAGS -coverprofile=$t $@ \
        && go tool cover -func=$t \
        && unlink $t
}

check-github-notifications () {
  lines=`gh notify -s | wc -l`

  if ((lines < 1))
  then
    echo "No notifications!"
  else
    gh notify
  fi
}

count-github-notifications () {
  lines=`gh notify -s | wc -l`
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  PURPLE='\033[0;35m'
  NC='\033[0m' # No Color

  if ((lines < 1))
  then
    printf "${GREEN}$lines notifications!${NC}\n"
  else
    printf "${PURPLE}$lines notifications${NC}\n"
  fi
}

gn-watch () {
  while :;
    do
    clear
    date
    count-github-notifications
    sleep 120
  done
}

alias grr="go run main.go"
alias gn="check-github-notifications"
alias :q="exit"
alias gg="lazygit"
alias lzn='lazynpm'

# requires cht.sh and rlwrap
if type rlwrap &> /dev/null; then
  alias cht="cht.sh --shell"
else
  alias cht="echo 'must have rlwrap installed'"
fi

# Repo specific config

# Search available npm commands
alias ncl="npm run command-list"

# Set the base for comparisons for "affected" files.
# Should reduce the number of checks run
export NX_BASE=upstream/main

alias check="pre-commit run --all-files && npm run test"


# End repo specific config

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# install keybindings if not set up
# $(brew --prefix)/opt/fzf/install
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Ensure homebrew is in path
 # eval "$(homebrew/bin/brew shellenv)"

# brew install starship
# https://starship.rs/guide/#%F0%9F%9A%80-installation
if type starship &> /dev/null; then
  eval "$(starship init zsh)"
fi
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# completions for graphite CLI
#compdef gt
###-begin-gt-completions-###
#
# yargs command completion script
#
# Installation: /opt/homebrew/bin/gt completion >> ~/.zshrc
#    or /opt/homebrew/bin/gt completion >> ~/.zprofile on OSX.
#
_gt_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" /opt/homebrew/bin/gt --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _gt_yargs_completions gt
###-end-gt-completions-###

