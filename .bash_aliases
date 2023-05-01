#!/bin/bash

#export SVN_EDITOR=nano
#alias svn-propedit="svn pe svn:externals ."
#alias svn-editor-nano="export SVN_EDITOR=nano"
#alias svn-editor-gedit="export SVN_EDITOR=gedit"
#alias svn-st="svn st | ag '^([ACDEIGLMRUX!?])|([M])'"
#alias svnst="svn st -q"

# sets ll to print file size in Megabytes. Change M to K to inspect smaller filesizes
alias ll='ls -alF --block-size=M'

alias gs="git status"
alias glg="git log --graph --pretty=format:'%Cred%h%Creset - %C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gpl="git pull"
alias gc="git checkout"
alias gsm="git submodule"
alias gsmfe="git submodule foreach"
alias gsmb="git submodule | ag 'heads\/(?!(master|main))'" # prints the branches that the submodules on, if they aren't on heads/master or heads/main
alias gfh="git log -p -- <file>" # prints the change history of a file
alias git-show-url="git config --get remote.origin.url"
alias gdwc="git difftool origin/<other-branch>:src/file.cpp src/file.cpp" # diffs file.cpp from another branch to the current working copy

checksum_256_compare() {
    # argument 1: expected sha256 file hash
    # argument 2: name of file to be checked
    sha256sum -c <<<""$1" "$2""
}

# prints the number of files in the current directory
alias count-files-in-dir='ls -1 | wc -l'

# show ports that processes are currently using
alias show-port-use='sudo netstat -plant'

# open file with the configured filetype association
alias open-file='sudo xdg-open'

# find the applications that can open a given file
find_filetype_associations_for(){
    mime_file_type="$(xdg-mime query filetype "$1")"
    if [ $? -eq 0 ]; then
        ag -l "$mime_file_type" /usr/share/applications/*
    fi
}

diff-binary() {
    diff <(xxd "$1") <(xxd "$2")
}

# Bash terminal wipe
alias cls='printf "\033c"'
 
# Clears the Dish cache of the sda disk. Useful for testing load times from fresh start
alias clear-disk-cache='echo 3 | sudo tee /proc/sys/vm/drop_caches && sudo blockdev --flushbufs /dev/sda'
 
# commands to enable or disable swap
alias turn-swap-off="sudo swapoff -a"
alias turn-swap-on="sudo swapon -a"

alias replace-word="grep -rli \'old-word\' * | xargs -i@ sed -i \'s/old-word/new-word/g\' @"

alias postgres-connect="psql -U postgres -h localhost"
alias postgres-execute-script="psql -U postgres -v ON_ERROR_STOP=1 -1 -h localhost -f <sql file to execute> <database name>"

alias desktop-file-locations="echo 'check the \"applications\" folder within these directories: $XDG_DATA_DIRS'"
