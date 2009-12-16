function parrot-uninstall {
    sudo rm -rfv /usr/local/bin/parrot*
    sudo rm -rfv /usr/local/bin/pbc*
    sudo rm -rfv /usr/local/lib/parrot*
    sudo rm -rfv /usr/local/lib/libparrot*
    sudo rm -rfv /usr/local/src/parrot*
    sudo rm -rfv /usr/local/include/parrot*
}

WKPARROTUSECCACHE=""
which ccache &> /dev/null && WKPARROTUSECCACHE="--cc='ccache gcc'"

WKPARROTMAINTAINER=""
which flex &> /dev/null && which bison &> /dev/null && WKPARROTMAINTAINER="--maintainer"

alias pc="perl Configure.pl $PARROTUSECCACHE $PARROTMAINTAINER"
alias pcn="parrot-nqp Configure.nqp"

# What to do here if g++ is not installed? Just let Configure.pl catch it?
alias pc++="perl Configure.pl $PARROTMAINTAINER --cc=g++ --cxx=g++ --link=g++"

# I find 5 is a pretty optimum number, don't need to use NUMTHREADS.
alias pt="mj TEST_JOBS=5"

