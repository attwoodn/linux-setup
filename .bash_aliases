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

# prints the number of files in the current directory
alias count-files-in-dir='ls -1 | wc -l'

# show ports that processes are currently using
alias show-port-use='sudo netstat -plant'
alias check-port-1="sudo netstat -plant | grep <port>"
alias check-port-2="sudo lsof -nPi | grep <port>"

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

alias own-this-folder="sudo chown -R na15sw:na15sw ."

alias watch-time="watch -n 0.1 date +\"%T.%6N\""

# open file with the configured filetype association
alias open-file='sudo xdg-open'

# find the applications that can open a given file
find_filetype_associations_for(){
    mime_file_type="$(xdg-mime query filetype "$1")"
    if [ $? -eq 0 ]; then
        ag -l "$mime_file_type" /usr/share/applications/*
    fi
}

checksum_256_compare() {
    # argument 1: expected sha256 file hash
    # argument 2: name of file to be checked
    sha256sum -c <<<""$1" "$2""
}

diff-binary() {
    diff <(xxd "$1") <(xxd "$2")
}

ginfo() {
    bitbucket_url_begin="bitbucket:7990/projects"
    
    given_path="$1"
    if [ -z "$given_path" ]; then
        given_path="."
    fi
    
    if [ ! -d "$given_path" ]; then
        echo -e "Error: no such directory $given_path\n"
        return
    fi
    
    git_path=$(command -v git)
    
    if [ -z "$git_path" ]; then
        echo -e "Error: git is not installed\n"
        return
    fi
    
    cd "$given_path"
    
    is_git_repo=$(git rev-parse --is-inside-work-tree 2> /dev/null)
    
    if [ "$is_git_repo" != "true" ]; then
        echo -e "Error: not a git repository\n"
        cd - 1> /dev/null
        return
    fi
    
    # set the delimiter for the subsequent read command ...
    IFS=":"
    
    # and then read in the repo URL (something like "ssh://git@bitbucket:7999/products/my-project.git") and split it using the delimiter
    read -a repo_url <<< "$(git config --get remote.origin.url)"
    
    # and again...
    IFS="."
    read -a repo_url <<< "${repo_url[2]}"
    
    # and again...
    IFS="/"
    read -a repo_url <<< "${repo_url[0]}"
    
    if [ -z "$repo_url" ]; then
        repo_url="<Parse Error>"
    else
        repo_url="$bitbucket_url_begin/${repo_url[1]}/repos/${repo_url[2]}/browse"
    fi
    
    # for (( n=1; n < ${#repo_url[*]}; n++))
    #do
    #  echo "${repo_url[n]}"
    #done
    
    echo "Path: $given_path"
    echo "Branch: $(git branch --show-current)"
    echo "Cloned URL: $(git config --get remote.origin.url)"
    echo "Bitbucket URL: $repo_url"
    echo "Last Changed Author: $(git log -n 1 --pretty=format:"%an")"
    echo "Last Changed Rev: $(git log -n 1 --pretty=format:"%h")"
    echo "Last Changed Date: $(git log -n 1 --pretty=format:"%ad")"
    echo -e "Last Changed Msg: $(git log -n 1 --pretty=format:"%s")\n"
    
    cd - 1> /dev/null
}
