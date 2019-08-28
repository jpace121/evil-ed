alias sub-point="git submodule foreach -q --recursive 'git checkout $(git config -f $toplevel/.gitmodules submodule.$name.branch || echo master)'"
alias sub-update="git submodule update --remote"
