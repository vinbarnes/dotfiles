# amnesia
export HISTIGNORE="ls:ll:l:pwd:pwb:date"
HISTCONTROL=ignoreboth
shopt -s histappend
HISTFILESIZE=10000
HISTSIZE=10000
HISTTIMEFORMAT="%F %T "
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$n}history -a; history -c; history -r;"

set -o physical

##
# look in brew first
#
# export PATH=/usr/local/bin:$PATH

export EDITOR=emacsclient
export VISUAL=emacsclient
export GIT_EDITOR=emacsclient

##
# rbenv
#
# export RBENV_ROOT=/usr/local/var/rbenv

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

##
# pyenv
#

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

alias empy="DB_PORT=5434 DB_USER=barnesk python "

alias ll="ls -Alh"
alias l="ll"

### Added by the Heroku Toolbelt
# export PATH="/usr/local/heroku/bin:$PATH"

function setrb {
    echo $1 > .ruby-version

}

##
# I cant believe Im doing this
#
# export NVM_DIR=~/.nvm
# source $(brew --prefix nvm)/nvm.sh

# The next line enables bash completion for gcloud.
#. /Users/barnekr/bin/google-cloud-sdk/completion.bash.inc

function gg {
    grep -n -R -i -I $1 $2
}

# git helpers
function pwb {
    git symbolic-ref --short HEAD
}

function upstream_branch {
    upstream=`git branch --list -vv $(pwb) | cut -d ] -f 1 | cut -d [ -f 2`

    if [[ $upstream == *":"* ]]
    then
        upstream_name=`echo $upstream | cut -d : -f 1`
    else
        upstream_name=$upstream
    fi

    echo $upstream_name
}

function tigup {
    tig ..$(upstream_branch)
}

function gmup {
    git merge $(upstream_branch)
}

function grup {
    git rebase $(upstream_branch)
}

# zeumo
zeumo_code_dir="$HOME/Code/zeumo"
zeumo_app_dir="$zeumo_code_dir/zeumo-app"
zeumo_deploy_dir="$zeumo_code_dir/deploy"

alias cz="cd $zeumo_app_dir"
alias czd="cd $zeumo_deploy_dir"

gce_with_path="$zeumo_deploy_dir/ship"
alias z="$gce_with_path"
alias ziprod="$gce_with_path instances -e production"
alias zidemo="$gce_with_path instances -e demo"
alias ziplay="$gce_with_path instances -e playground"

# fix for warning: "pinentry-curses: no LC_CTYPE known - assuming UTF-8"
export GPG_TTY=`tty`

alias rt="RAILS_ENV=test rake spec"
alias rs="rails s"
alias rc="rails c"
alias be="bundle exec"

# The next line updates PATH for the Google Cloud SDK.
source '/usr/local/var/google-cloud-sdk/path.bash.inc'

# The next line enables shell command completion for gcloud.
source '/usr/local/var/google-cloud-sdk/completion.bash.inc'

# Vault setup for deploys
export VAULT_ADDR='https://vault.crimsonconnect.com'

# LastPass
export LPASS_AUTO_SYNC_TIME=14400
export LPASS_AGENT_TIMEOUT=14400

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# for shits and giggles
alias beigesway='mplayer -loop 0 -softvol -softvol-max 200 -volume 30 ~/Documents/audiocheck.net_BrownNoise_15min.mp3'
export PATH="$HOME/bin:/Users/barnesk/Code/zeumo/deploy/bin:$PATH"
export CDPATH=".:~:~/Links"

source /usr/local/opt/autoenv/activate.sh

# stop fucking with my prompt
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# keychain config
eval `keychain --eval --quiet --agents ssh advisory_bitbucket_id_rsa`

# keep it simple stupid
PS1='\u@\h:\W $ '
