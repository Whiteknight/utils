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
WKPARROTUSECCACHE=""
which ccache &> /dev/null && WKPARROTUSECCACHE="--cc='ccache gcc'"

# If we have flex and bison, set that up. No sense in not using them
WKPARROTMAINTAINER=""
which flex &> /dev/null && which bison &> /dev/null && WKPARROTMAINTAINER="--maintainer"

# Configuration shorthands.
alias pc="perl Configure.pl $WKPARROTUSECCACHE $WKPARROTMAINTAINER"
alias pcn="parrot-nqp Configure.nqp"
alias pcs="parrot setup.pir build"
# What to do here if g++ is not installed? Just let Configure.pl catch it?
alias pc++="perl Configure.pl $WKPARROTMAINTAINER --cc=g++ --cxx=g++ --link=g++"
# TODO: Add configuration shorthands for other compilers too (LLVM?)

# I find 5 is a pretty optimum number, don't need to use NUMTHREADS.
alias pt="make TEST_JOBS=5"

