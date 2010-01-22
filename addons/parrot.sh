# Addons to make life easier developing Parrot

# If we have ccache, use that because it speeds things up significantly
#WKPARROTUSECCACHE=""
#which ccache &> /dev/null && WKPARROTUSECCACHE="--cc='ccache gcc'"

# Configuration/build routines for projects using parrot-nqp or setup.pir
alias pcn="parrot-nqp Configure.nqp"
alias pcs="parrot setup.pir build"

#Setup some arguments that are always used to configure Parrot
WKPARROTSTDARGS="--no-line-directives"

# Parrot configuration. If the first argument is the name of a supported compiler,
# use that compiler. Otherwise all arguments are passed to Configure.pl
function pc {
    local WKCOMMANDLINE="";
    case $1 in
        "gcc")
            shift;
            local WKCOMPILER="gcc"
            __find_command ccache && WKCOMPILER="ccache gcc"
            WKCOMMANDLINE="--cc='$WKCOMPILER' --link=gcc --ld=gcc"
            ;;
        "clang")
            if ! __find_program clang; then
                echo "clang not installed"
                return 1
            fi
            shift
            WKCOMMANDLINE="--cc=clang --link=clang --ld=clang"
            ;;
        "g++")
            if ! __find_program g++; then
                echo "g++ not installed"
                return 1
            fi
            shift
            WKCOMMANDLINE="--cc=g++ --cxx=g++ --link=g++"
            ;;
        "icc")
            if [ ! -e $WKICC ]; then
                echo "icc not installed or not found"
                return 1
            fi
            shift
            WKCOMMANDLINE="--cc=icc --link=icc --ld=icc"
            ;;
        "icpc")
            if [ ! -e $WKICC ]; then
                echo "icpc/icc not installed or not found"
                return 1
            fi
            shift
            WKCOMMANDLINE="--cc=icpc --cxx=icpc --link=icpc --ld=icpc"
            ;;
    esac

    # If we have flex and bison, set that up. No sense in not using them
    local WKPARROTMAINTAINER=""
    __find_program flex bison && WKPARROTMAINTAINER="--maintainer"

    if [ -e "Configure.pl" ]; then
        echo "Configuring with: '$WKPARROTMAINTAINER $WKCOMMANDLINE $WKPARROTSTDARGS $*'"
        perl Configure.pl $WKPARROTMAINTAINER $WKCOMMANDLINE $WKSTDARGS $*
    else
        echo "Configure.pl not found."
    fi
}

# I find 5 is a pretty optimum number, don't need to use NUMTHREADS.
alias pt="make TEST_JOBS=5"

# Functions to work with Parrot

# Uninstall an installed Parrot. Nuke.
function parrot-uninstall {
    sudo rm -rfv /usr/local/bin/parrot*
    sudo rm -rfv /usr/local/bin/pbc*
    sudo rm -rfv /usr/local/lib/parrot*
    sudo rm -rfv /usr/local/lib/libparrot*
    sudo rm -rfv /usr/local/src/parrot*
    sudo rm -rfv /usr/local/include/parrot*
}

# An end-to-end test of Parrot with a given compiler
function parrot-smoke {
    if [ -e "Makefile" ]; then
        make realclean
    fi
    pc $*
    mj
    make smoke
}

# Function to checkout parrot trunk or a particular branch.
function parrot-get {
    local PARROTFOLDER=${1:"parrot"}
    if [ ! -e $WKPROJECTS/$PARROTFOLDER ]; then
        if [ $PARROTFOLDER == "parrot" ]; then
            svn co https://svn.parrot.org/parrot/trunk $WKPROJECTS/parrot
        else
            svn co https://svn.parrot.org/parrot/branches/$PARROTFOLDER $WKPROJECTS/$PARROTFOLDER
        fi
    fi
}
