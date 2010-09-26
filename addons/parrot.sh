# Addons to make life easier developing Parrot

# If we have ccache, use that because it speeds things up significantly
#WKPARROTUSECCACHE=""
#which ccache &> /dev/null && WKPARROTUSECCACHE="--cc='ccache gcc'"

# Configuration/build routines for projects using parrot-nqp or setup.pir
alias pcn="parrot-nqp Configure.nqp"
alias pcs="parrot setup.pir build"

# Setup some arguments that are always used to configure Parrot
# --no-line-directives seems to cause some problems now
WKPARROTSTDARGS=""

# Var to simplify parrot svn operations
PARROTSVN="https://svn.parrot.org/parrot"

# Parrot configuration. If the first argument is the name of a supported compiler,
# use that compiler. Otherwise all arguments are passed to Configure.pl
function pc {
    local WKCOMMANDLINE="";
    case $1 in
        "gcc")
            shift;
            local WKCOMPILER="gcc"
            __find_program ccache && WKCOMPILER="ccache gcc"
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
        "suncc")
            if ! __find_program suncc; then
                echo "suncc not installed"
                return 1
            fi
            shift
            WKCOMMANDLINE="--cc=suncc --link=suncc --ld=suncc"
            ;;
        *)
        pc $WKCC
        return;
    esac

    # If we have flex and bison, set that up. No sense in not using them
    local WKPARROTMAINTAINER=""
    #__find_program flex bison && WKPARROTMAINTAINER="--maintainer"

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
    sudo rm -rfv /usr/local/include/pmc*
}

# An end-to-end test of Parrot with a given compiler
function parrot-smoke {
    if [ -e "Makefile" ]; then
        make realclean
    fi
    pc $* && mj && mj smoke
}

# Test everything, end-to-end
function parrot-testall {
    parrot-smoke clang
    parrot-smoke clang --optimize
    parrot-smoke gcc
    parrot-smoke gcc --optimize
    parrot-smoke g++
    parrot-smoke g++ --optimize
    parrot-smoke icc
    parrot-smoke icc --optimize
    parrot-smoke suncc
    parrot-smoke suncc --optimize
}

# Function to checkout parrot trunk or a particular branch.
function parrot-get {
    local PARROTFOLDER=${1:-"parrot"}
    # TODO: Should have a way to get the latest RELEASE tag.
    if [ ! -e $WKPROJECTS/$PARROTFOLDER ]; then
        if [ $PARROTFOLDER == "parrot" ]; then
            svn co $PARROTSVN/trunk $WKPROJECTS/parrot
        else
            svn co $PARROTSVN/branches/$PARROTFOLDER $WKPROJECTS/$PARROTFOLDER
        fi
    fi
    pg $PARROTFOLDER
}

function m {
    [ -e ./setup.nqp ] && parrot-nqp setup.nqp $*
    [ -e ./setup.pir ] && parrot setup.pir $*
    [ -e ./Configure.pl ] && perl Configure.pl $*
    [ -e ./Makefile ] && mj
}



