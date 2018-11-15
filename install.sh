#!/usr/bin/env bash

ruby -run -e cp -- -v ./bash/.bash_profile ~/.bash_profile

ruby -run -e mkdir -- -p -v ~/.emacs.d
ruby -run -e cp -- -r -v ./emacs/* ~/.emacs.d/

ruby -run -e cp -- -v ./homebrew/global/Brewfile ~/.Brewfile
