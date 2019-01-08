#!/usr/bin/env sh

#UNTESTED:  Should make emc be an alias for emacsclient for ease of typing when
# emacs --daemon has already been started.

echo '===> Aliasing emc. May need to run source once done.'
# OSX and Linux have different preferred places to dump
# shell aliases
if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    echo 'alias emc='\''emacsclient -t --alternate-editor=""'\''' >> ~/.bashrc
else
    echo 'alias emc='\''emacsclient -t --alternate-editor=""'\''' >> ~/.bash_profile
fi
