##
# temporary debugging after switching to homebrew bash v4.3.x
#
echo shell: $BASH $BASH_VERSION

##
# look in binstubs first, then brew
#
export PATH="~/bin:.bin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/postgresql-9.3/bin:/usr/local/heroku/bin:$PATH"

##
# his story
#
export HISTCONTROL="erasedups:ignoreboth"
export HISTFILESIZE=50000
export HISTSIZE=10000
export HISTIGNORE="exit"

shopt -s histappend
shopt -s cmdhist
shopt -s globstar

##
# rbenv
#
# export RBENV_ROOT=/usr/local/var/rbenv

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

alias ll="ls -Al"
alias l=ll
alias pwb="git rev-parse --abbrev-ref HEAD"
alias guard="guard --no-bundler-warning"

export CDPATH=":~Code/lonelyplanet:~/Code/vinbarnes"

shopt -s cdable_vars

export lp="/Users/*****/Code/lonelyplanet"
export me="/Users/*****/Code/vinbarnes"

alias p91="sudo -u _postgres /usr/local/opt/postgresql-9.1/bin/psql postgres"
alias p93="sudo -u _postgres /usr/local/opt/postgresql-9.3/bin/psql postgres"
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

export EDITOR="emacs"

alias blerg="bundle"

# project specific conveniences
alias test='ES_HOST=canary.elasticsearch.lonelyplanet.com ES_PORT=9200 blerg exec rspec ./spec'
