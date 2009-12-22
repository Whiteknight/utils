# Add these lines to your ~/.bashrc and maybe your /root/.bashrc files:
#
#     WKPROJECTS=<your projects directory here>
#     . $WKPROJECTS/utils/utils
#     . $WKPROJECTS/utils/parrot_utils
#
# If you don't set WKPROJECTS, it will default to "/home/andrew/projects"
WKPROJECTS=${WKPROJECTS:-'/home/andrew/projects'}

# OpenSolaris doesn't have lspci, scanpci does the same thing, but requires
# sudo, which I don't want to use for startup scripts like this. So, need to
# find an alternate way to do this.
WKLSPCI="lspci"
if ! which lspci &> /dev/null; then
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
        if which VBoxClient &> /dev/null; then
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
    which ${WKEDITORLIST[WKIVAR]} &> /dev/null && WKEINTERNAL=${WKEDITORLIST[WKIVAR]}
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
    if which ${WKPKGMANAGERLIST[WKIVAR]} &> /dev/null; then
        WKGETINTERNAL=${WKPKGMANAGERLIST[WKIVAR]}
        WKDISTROTYPE=${WKDISTROLIST[WKIVAR]}
    fi
    ((WKIVAR++))
done
alias getpkg="sudo $WKGETINTERNAL install"
WKDISTROTYPE=${WKDISTROTYPE:-"Unknown"}

# Display some basic information in a header on console startup
echo "$WKVIRTUALHOST$WKVIRTUALADDITIONS: $WKDISTROTYPE - editor: $WKEINTERNAL - packager: $WKGETINTERNAL"

function __update_version {
    WKPGVERSION=$(perl $WKPROJECTS/utils/get_version.pl)
    WKPGPROJECT=${WKPGPROJECT:-$(pwd)}
    PS1="\n<$WKPGPROJECT $WKPGVERSION> "
}

function pg {
    WKPGPROJECT=$1
    cd $WKPROJECTS/$1 && __update_version
    pwd
}

function up {
    if [ -e ".svn" ]; then
        svn update
        __update_version
        return
    fi
    if [ -e ".git" ]; then
        git pull
        return
    fi
}


