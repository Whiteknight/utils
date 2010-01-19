# Add these lines to your ~/.bashrc (or ~/.bashrc.local) and maybe your
# /root/.bashrc files:
#
#     WKPROJECTS=<your projects directory here>
#     . $WKPROJECTS/utils/utils
#
# Note: All variables in use here will be named WK* to prevent collisions.
#
# If you don't set WKPROJECTS, it will default to "/home/andrew/projects", but
# won't be available in your .bashrc file
WKPROJECTS=${WKPROJECTS:-'/home/andrew/projects'}

# Log function. Things that happen automatically should be logged.
function __setup_log {
    echo "$*"
    echo "$*" >> ~/UtilsSetup.log
}

function __find_program {
    which $1 >& /dev/null
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

# OpenSolaris doesn't have lspci, scanpci does the same thing, but requires
# sudo, which I don't want to use for startup scripts like this. So, need to
# find an alternate way to do this.
WKLSPCI="lspci"
if ! __find_program lscpi; then
    WKLSPCI="scanpci"
fi

# Figure out if we are being run virtually inside VirtualBox and, if so,
# whether we have the guest additions installed. Note that in OpenSolaris
# I can't really detect this now, so I pretend we aren't virtualized no matter
# what the reality is.
WKVIRTUALHOST="System"
WKVIRTUALADDITIONS=""
if [ "$WKLSPCI" != "scanpci" ]; then
    $WKLSPCI | (grep "VirtualBox" &> /dev/null)
    if [ "$?" -eq "0" ]; then
        WKVIRTUALHOST="VirtualBox"
        if __find_program VBoxClient; then
            WKVIRTUALADDITIONS=""
        else
            WKVIRTUALADDITIONS=" NO GUEST ADDITIONS "
        fi
    fi
fi

# Number of simultaneous threads we use for make. This should be
# number_of_processors + 1. In a virtual environment where we are resource
# constrained, only use one.
WKNUMTHREADS=3
[ "$WKVIRTUALHOST" == "VirtualBox" ] && WKNUMTHREADS=1

alias mj="make -j$WKNUMTHREADS"
alias projects="cd $WKPROJECTS && PS1='\n<projects> ' && ls --color=always"
alias ls="ls --color=auto"
alias ll="ls --color=auto -l"
alias la="ls --color=auto -a"

# Pick an editor to launch when I lazily type "e". Start with preferences
WKEDITORLIST=( gedit kwrite medit )
WKEDITORLISTCNT=${#WKEDITORLIST[@]}
WKIVAR=0
WKEINTERNAL="echo 'no editors found'"
while [ "$WKIVAR" -lt "$WKEDITORLISTCNT" ];
do
    __find_program ${WKEDITORLIST[WKIVAR]} && WKEINTERNAL=${WKEDITORLIST[WKIVAR]}
    ((WKIVAR++))
done
function e { $WKEINTERNAL $* & }

# Figure out what the package manager on this system is. Also, we'll use this
# to make sweeping generalizations about the distro we're using
WKPKGMANAGERLIST=( apt-get yum pkg zypper )
WKDISTROLIST=( Debian Fedora Solaris SuSE )
WKPKGMANAGERLISTCNT=${#WKPKGMANAGERLIST[@]}
WKIVAR=0
WKGETINTERNAL="echo 'no package managers found'"
while [ "$WKIVAR" -lt "$WKPKGMANAGERLISTCNT" ]
do
    if __find_program ${WKPKGMANAGERLIST[WKIVAR]}; then
        WKGETINTERNAL=${WKPKGMANAGERLIST[WKIVAR]}
        WKDISTROTYPE=${WKDISTROLIST[WKIVAR]}
    fi
    ((WKIVAR++))
done
alias getpkg="sudo $WKGETINTERNAL install"
WKDISTROTYPE=${WKDISTROTYPE:-"Unknown"}

# Setup our addons list. We do this last because the addons may depend on
# Things in this file
WKADDONS="Addons: "
for WKTEMPF in $WKPROJECTS/utils/addons/*.sh; do
    source $WKTEMPF;
    WKADDONS="$WKADDONS ${WKTEMPF##*/}"
done

# Display some basic information in a header on console startup
echo "$WKVIRTUALHOST$WKVIRTUALADDITIONS: $WKDISTROTYPE - editor: $WKEINTERNAL - packager: $WKGETINTERNAL"
echo "$WKADDONS"

function __update_version {
    WKPGVERSION=$(perl $WKPROJECTS/utils/get_version.pl)
    WKPGPROJECT=${WKPGPROJECT:-$(pwd)}
    PS1="\n<$WKPGPROJECT $WKPGVERSION> "
    return 0
}

function pg {
    WKPGPROJECT=$1
    cd $WKPROJECTS/$1 && __update_version &&  pwd
}

function up {
    [ -e ".svn" ] && svn update $*
    [ -e ".git" ] && git pull $*
    __update_version
}
