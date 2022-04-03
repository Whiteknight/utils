alias ls='ls --color'

cdl () {
    cd $1 && ls
}

_pg_goto ()
{
    if [ -e /c/projects/$1 ]; then 
        cd /c/projects/$1;
        return 0;
    fi
	if [ -e /c/tfs/$1 ]; then 
        cd /c/tfs/$1;
        return 0;
    fi
    if [ -e /c/containers/$1 ]; then
        cd /c/containers/$1;
        return 0;
    fi

    cdl /c/projects;
    return 1;
}

pg ()
{
    if _pg_goto $1; then

        # If we have a setup script here, invoke it
        if [ -e ./.pg.sh ]; then 
            . ./.pg.sh
        fi
    else
        echo Project $1 not found
    fi
}


