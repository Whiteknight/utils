# Functions for working with virtualbox
function mountshare {
    if [ ! -d ~/VBoxShares ]; then
	mkdir ~/VBoxShares
    fi
    if [ ! -d ~/VBoxShares/$1 ]; then
        sudo mkdir ~/VBoxShares/$1
    fi
    # TODO: Check that it isn't already mounted
    sudo mount.vboxsf $1 ~/VBoxShares/$1
    cd ~/VBoxShares/$1
    pwd
    ls --color=auto
}

function umountshare {
    sudo umount ~/VBoxShares/*
}
