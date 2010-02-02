# This is a basic setup utility for a new computer. Try to get some of the
# basic tools that I use and try to setup some of the basic settings I like.
# The process will be very interactive in parts

function global_setup {
    source $WKPROJECTS/utils/scripts/global_setup.sh
    echo "All done. Press any key to continue"
    read -n 1 -s
    exit
}

function compilers {
    echo "no"
}
