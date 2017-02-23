ZSH=$HOME/.oh-my-zsh
ZSH_THEME="rbates"
DISABLE_AUTO_UPDATE="true"
DISABLE_LS_COLORS="true"

plugins=(git bundler brew gem rbates)

export PATH="/usr/local/bin:$PATH"
export EDITOR='mate -w'

source $ZSH/oh-my-zsh.sh

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"
PROMPT='%B%m%~%b$(git_super_status) %#' 

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

function futurePreRelease {
  git stash
  git checkout master
  if [ $? -ne 0 ] ; then return; fi
  git pull
  if [ $? -ne 0 ] ; then return; fi
  git checkout develop
  git pull
  latestTag=$(git describe origin/master)
  echo "Changes since" $latestTag
  git shortlog --format="%s" --grep "pull request" $latestTag..HEAD
}

# takes the release number as a parameter
function futureRelease {
  git flow release start ${1}
  if [ $? -ne 0 ] ; then return; fi
  git flow release publish ${1}
  if [ $? -ne 0 ] ; then return; fi
  cap staging deploy:rolling -S branch=release/${1}
}

# takes the release number as a parameter
function futureFinishRelease {
  git pull
  git flow release finish ${1}
  if [ $? -ne 0 ] ; then return; fi
  git pull
  git push
  if [ $? -ne 0 ] ; then return; fi
  git push --tags
  if [ $? -ne 0 ] ; then return; fi
  git checkout master
  if [ $? -ne 0 ] ; then return; fi
  git push
  if [ $? -ne 0 ] ; then return; fi
  cap production deploy:rolling
}

eval "$(thefuck --alias)"

export WORKSPACE=~/Desktop/fa_code
export DOT_FA=$WORKSPACE/dot-futureadvisor
export REMOTE_USER_NAME=`whoami`
# uncomment the line below and add your correct username if whoami is not the same as your login
export REMOTE_USER_NAME='teagan'
source $DOT_FA/futureadvisor
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_112.jdk/Contents/Home
export PATH="$PATH:$JAVA_HOME/bin"

export PATH="/usr/local/heroku/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


PATH="$PATH:Users/tkwidmer/.rvm/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/bin:/sbin:/Users/tkwidmer/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
