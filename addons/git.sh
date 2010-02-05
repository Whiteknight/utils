# Utilities for working with git and github

function github-get {
    # TODO: $2 can be the local name of the folder
    local HASSLASH=$(expr index "$1" /)
    local PROJECTNAME=""
    if [ "$HASSLASH" == "0" ]; then
        PROJECTNAME=$1
        git clone git@github.com:Whiteknight/${1}.git $WKPROJECTS/$1
    else
        local PROJECTNAME=${1##*/}
        git clone git@github.com:${1}.git $WKPROJECTS/$PROJECTNAME
    fi
    pg $PROJECTNAME
    git config push.default current
}

function github-create {
    # TODO: Create a new repo in $WKPROJECTS/$1, git init, push to github.
    # TODO: Create default files README.pod, LICENSE for initial commit
}
