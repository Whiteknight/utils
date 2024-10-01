alias ls='ls --color'
alias ll='ls -l'

cdl () {
    cd $1 && ls
}

pg ()
{
    # Projects is where I hold code projects I'm working on, usually git repos
    if [ -e /c/projects/$1 ]; then 
        cd /c/projects/$1;
        ls;
        return 0;
    fi
    if [ "$1" == "projects" ]; then
        cd /c/projects;
        ls;
        return 0;
    fi

    # If I'm unlucky enough to work with TFS, we'll map it to this directory
    # (And hope for better days)
    if [ -e /c/tfs/$1 ]; then 
        cd /c/tfs/$1;
        ls;
        return 0;
    fi

    # Containers is where I put info related to general-purpose docker 
    # containers to enhance my local env
    # These are source-controlled in utils/containers
    if [ -e /c/containers/$1 ]; then
        cd /c/containers/$1;
        ls;
        return 0;
    fi
    if [ "$1" == "containers" ]; then
        cd /c/containers;
        ls;
        return 0;
    fi

    # Tasks is where I store anything else I might be working on that isn't a
    # code repo or setup for a container. 
    if [ -e /c/tasks/$1 ]; then
        cd /c/tasks/$1;
        ls;
        return 0;
    fi
    if [ "$1" == "tasks" ]; then
        cd /c/tasks;
        ls;
        return 0;
    fi
    
    # Couldn't find a matching directory, so dump us in projects with a message
    echo Project $1 not found
    cd /c/projects;
    ls;
}

pglist() 
{
    set OLDDIR=$PWD;
    
    echo Projects
    cd /c/projects;
    ls;
    
    echo Tasks
    cd /c/tasks;
    ls;
    
    echo Containers
    cd /c/containers;
    ls;
    
    cd $OLDDIR;
}

