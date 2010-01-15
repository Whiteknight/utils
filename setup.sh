
# This is a basic setup utility for a new computer. Try to get some of the
# basic tools that I use and try to setup some of the basic settings I like.
# The process will be very interactive in parts
function global_setup {
    __setup_log "Starting setup at " $(date)
    __general_setup
    __ssh_setup
    __projects_setup
    __git_setup
    __utils_setup
    __svn_setup
    __dev_setup
    __setup_log "Done at " $(date)
    echo "Everything appears to be setup!"
}

function __general_setup {
    __get_program medit medit
    __get_program nano nano
}

function __ssh_setup {
    # Just follow the instructions
    if [ ! -f ~/.ssh/id_rsa.pub ]; then
        __setup_log "Setting up ssh key..."
        ssh-keygen -t rsa -C "wknight8111@gmail.com"
        __setup_log "Done."
    fi
    # Run this to see if we have access.
    ssh git@github.com
    if [ "$?" == "255" ]; then
        __setup_log "Setting up SSH access to Github"
        echo "Add the following SSH key to github:"
        cat ~/.ssh/id_rsa.pub
        # TODO: What about console-only OS's?
        __setup_log "Opening Firefox..."
        firefox www.github.com &
        echo "Press any key to continue."
        read -n 1 -s
        __setup_log "Done."
    fi
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
    __get_program git git-core
    __setup_log "Setting up Git configuration..."
    git config --global user.name Whiteknight
    git config --global user.email "wknight8111@gmail.com"
    git config --global github.user Whiteknight
    __setup_log "Done."
}

function __svn_setup {
    __get_program svn subversion
}

function __dev_setup {
    __get_program flex flex
    __get_program bison bison
    # TODO: What else? gcc? binutils?
}


# HELPER FUNCTIONS
function __find_program {
    which $1 2>&1 > /dev/null
    return $?
}

function __get_program {
    __setup_log "Searching for $1 ($2)..."
    if ! __find_program $1; then
        __setup_log "Fetching $1 ($2)..."
        getpkg $2
    fi
    __setup_log "Done."
}
function __setup_log {
    echo "$*"
    echo "$*" >> ~/UtilsSetup.log
}
