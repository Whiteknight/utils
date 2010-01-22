# Addon to enable the project sandboxing commands I use

# Move to the projects root directory
alias projects="cd $WKPROJECTS && PS1='\n<projects> ' && ls --color=always"

# Update the prompt used when we change branch/version
function __update_version {
    local WKPGVERSION=$(perl $WKPROJECTS/utils/get_version.pl)
    WKPGPROJECT=${WKPGPROJECT:-$(pwd)}
    local WKPGTYPE=""
    [ -e ".svn" ] && WKPGTYPE="svn:"
    [ -e ".git" ] && WKPGTYPE="git:"
    PS1="\n<$WKPGPROJECT $WKPGTYPE$WKPGVERSION> "
    return 0
}

# Setup the environment for the given project
function pg {
    if [ "$#" == "0" ]; then
        WKPGPROJECT="NONE"
        __set_default_prompt
    else
        if [ -d $WKPROJECTS/$1 ]; then
            WKPGPROJECT=$1
            cd $WKPROJECTS/$1 && __update_version &&  pwd
        else
            WKPROJECT="NONE"
            echo "Project $1 not found."
        fi
    fi
}

# Update the given repo if it's a working copy. Do nothing otherwise
function up {
    # TODO: Check for local mods. In the case of git we might want to stash
    #       first.
    [ -e ".svn" ] && svn update $*
    [ -e ".git" ] && git pull $*
    __update_version
}

# Cleanup the given repo if it's a dirty working copy. Do nothing otherwise.
function cleanup {
    [ -e ".svn" ] && svn revert -R ./
    [ -e ".git" ] && git reset --hard
}

# TODO: Probably want a few more commands to paper over differences between git and svn
