alias ls='ls --color'

cdl () {
    cd $1 && ls
}

pg ()
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
}
