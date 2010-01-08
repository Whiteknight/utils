# Addons to make life easier developing Parrot

# Uninstall an installed Parrot. Nuke.
function parrot-uninstall {
    sudo rm -rfv /usr/local/bin/parrot*
    sudo rm -rfv /usr/local/bin/pbc*
    sudo rm -rfv /usr/local/lib/parrot*
    sudo rm -rfv /usr/local/lib/libparrot*
    sudo rm -rfv /usr/local/src/parrot*
    sudo rm -rfv /usr/local/include/parrot*
}

# If we have ccache, use that because it speeds things up significantly
#WKPARROTUSECCACHE=""
#which ccache &> /dev/null && WKPARROTUSECCACHE="--cc='ccache gcc'"

# Configuration/build routines for projects using parrot-nqp or setup.pir
alias pcn="parrot-nqp Configure.nqp"
alias pcs="parrot setup.pir build"

# Parrot configuration. If the first argument is the name of a supported compiler,
# use that compiler. Otherwise all arguments are passed to Configure.pl
function pc {
    # If we have flex and bison, set that up. No sense in not using them
    local WKPARROTMAINTAINER=""
    local WKCOMMANDLINE="$*"
    which flex &> /dev/null && which bison &> /dev/null && WKPARROTMAINTAINER="--maintainer"
    case $1 in
        "gcc")
            shift;
            WKCOMMANDLINE="--cc=gcc --link=gcc --ld=ld"
            ;;
        "clang")
            if ! which clang &> /dev/null; then
                echo "clang not installed"
                return 1
            fi
            shift
            WKCOMMANDLINE="--cc=clang --link=clang --ld=clang"
            ;;
        "g++")
            if ! which g++ &> /dev/null; then
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
    echo "Configuring with: '$WKMAINTAINER $WKCOMMANDLINE $*'"
    perl Configure.pl $WKPARROTMAINTAINER $WKCOMMANDLINE $*
}

# I find 5 is a pretty optimum number, don't need to use NUMTHREADS.
alias pt="make TEST_JOBS=5"

