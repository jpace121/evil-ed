#!/usr/bin/env sh

# Should make emc be an alias for emacsclient for ease of typing when
# emacs --daemon has already been started.
# Also installs ~/.tmux.conf if it has not already been placed in $HOME

echo '===> Aliasing emc. May need to run source once done.'
# OSX and Linux have different preferred places to dump
# shell aliases
if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    echo 'alias emc='\''emacsclient -t --alternate-editor=""'\''' >> ~/.bashrc
else
    echo 'alias emc='\''emacsclient -t --alternate-editor=""'\''' >> ~/.bash_profile
fi

echo '===> Symlinking tmux configuration file.'
if [ ! -f ~/.tmux.conf ]; then
   ln -s $HOME/.emacs.d/tmux.conf $HOME/.tmux.conf
else
   echo '===> ~/.tmux.conf already exists! Did not override.'
fi

