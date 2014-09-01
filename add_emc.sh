#!/usr/bin/env sh

#UNTESTED:  Should make emc be an alias for emacsclient for ease of typing when
# emacs --daemon has already been started.

echo '===> UNTESTED: You should verify this works.'
echo 'alias emc='emacsclient -t --alternate-editor=""'' >> ~/.bash_profile
source ~/.bash_profile
