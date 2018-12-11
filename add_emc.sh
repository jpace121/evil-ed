#!/usr/bin/env sh

#UNTESTED:  Should make emc be an alias for emacsclient for ease of typing when
# emacs --daemon has already been started.

echo '===> Aliasing emc. May need to run source once done.'
echo 'alias emc='\''emacsclient -t --alternate-editor=""'\''' >> ~/.bashrc
