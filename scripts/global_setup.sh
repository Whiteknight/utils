__setup_log "Starting setup at " $(date)

# SETUP SSH AND FRIENDS
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

# SETUP GIT
__get_program git git-core
__setup_log "Setting up Git configuration..."
git config --global user.name Whiteknight
git config --global user.email "wknight8111@gmail.com"
git config --global github.user Whiteknight
__setup_log "Done."

# SETUP SVN
__get_program svn subversion

# SETUP PROJECTS DIRECTORY
if [ ! -d ~/projects ]; then
    __setup_log "Creating projects directory..."
    mkdir ~/projects
    __setup_log "Done."
fi

# SETUP UTILITIES
if [ ! -d ~/projects/utils ]; then
    __setup_log "Getting utils..."
    git clone git@github.com:Whiteknight/utils ~/projects/utils
    __setup_log "Done."

    __setup_log "Setting up .bashrc..."
    cp ~/.bashrc ~/.bashrc_old
    echo "" >> ~/.bashrc
    echo "WKPROJECTS=$HOMEDIR/projects" >> ~/.bashrc
    echo ". \$WKPROJECTS/utils/utils"
    __setup_log "Done."
fi

# SETUP ADDITIONAL UTILITIES
__get_program medit medit
__get_program nano nano
__get_program flex flex
__get_program bison bison
# TODO: What else? gcc? binutils?

# SETUP PARROT DEPS
# TODO: What all do we need for parrot? GMP, ICC, PCRE, LIBCRYPTO, etc?

echo "Everything appears to be setup!"
__setup_log "Done at " $(date)
