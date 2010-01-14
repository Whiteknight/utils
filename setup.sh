
# This is a basic setup utility for a new computer. Try to get some of the
# basic tools that I use and try to setup some of the basic settings I like.
# The process will be very interactive in parts
function global_setup {
    if [ ! -e ~/UtilsSetup.log ]; then
        __general_setup
        __ssh_setup
        __projects_setup
        __git_setup
        __utils_setup
        __svn_setup
        
    fi
    echo "Everything appears to be setup!"
}

function __general_setup {
    if ! which medit 2>&1 > /dev/null; then
        __setup_log "Fetching medit..."
        getpkg medit
        __setup_log "Done."
    fi
    if ! which nano 2>&1 > /dev/null; then
        __setup_log "Fetching nano..."
        getpkg nano
        __setup_log "Done."
    fi
}

function __ssh_setup {
    # Just follow the instructions
    if [ ! -f ~/.ssh/id_rsa.pub ]; then
        __setup_log "Setting up ssh key..."
        ssh-keygen -t rsa -C "wknight8111@gmail.com"
        __setup_log "Done."
    fi
    echo "Add the following SSH key to github:"
    cat ~/.ssh/id_rsa.pub
    firefox www.github.com &
    read -n 1 -s
}

function __projects_setup {
    if [ ! -d ~/projects ]; then
        __setup_log "Creating projects directory..."
        mkdir ~/projects
        __setup_log "Done."
    fi
}

function __utils_setup {
    if [ ! -d ~/projects/utils ]; then
        __setup_log "Getting utils..."
        git clone git@github.com:Whiteknight/utils ~/projects/utils
        __setup_log "Done."

        __setup_log "Setting up .bashrc..."
        mv ~/.bashrc ~/.bashrc_old
        echo "" >> ~/.bashrc
        echo "WKPROJECTS=$HOMEDIR/projects" >> ~/.bashrc
        echo ". \$WKPROJECTS/utils/utils"
        __setup_log "Done."
    fi
}

function __git_setup {
    if ! which git 2>&1 > /dev/null; then
        __setup_log "Fetching git..."
        getpkg git-core
        __setup_log "Done."
    fi
    __setup_log "Setting up Git configuration..."
    git config --global user.name Whiteknight
    git config --global user.email "wknight8111@gmail.com"
    git config --global github.user Whiteknight
    __setup_log "Done."
}

function __svn_setup {
    if ! which svn 2>&1 > /dev/null; then
        __setup_log "Fetching svn..."
        getpkg subversion
        __setup_log "Done."
    fi
}

function __setup_log {
    echo "$*"
    echo "$*" >> ~/UtilsSetup.log
}
