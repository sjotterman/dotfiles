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


# https://superuser.com/questions/602882/how-to-make-zsh-completion-like-bash
setopt AUTO_LIST NO_MENUCOMPLETE
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="purify"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git npm zsh-autosuggestions z)

ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR="nvim"
export VISUAL="nvim"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
if type nvim &> /dev/null; then
  alias vim="nvim"
fi

# export NVM_DIR="/Users/samuel.otterman/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi
# Git aliases from Sky Eckstrom
alias git_diff_master="git diff upstream/master..`git rev-parse --abbrev-ref HEAD`"

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
