#! /bin/sh

print_usage() {
    echo "Use tpe to browse projects";
    echo "Use tpe r to refresh projects list";
    echo "Use tpe a to manually add project to list";
}

add_project_manually() {
    echo $1 >> ~/.tpemanual;
}

refresh_projects_list() {
    find ~/Documents -type d -name .git | sed "s/.git//g" > ~/.tpeprojects;
}

create_session() {
    project_dir=$(cat ~/.tpeprojects ~/.tpemanual| fzf) &&
    name=$(basename $project_dir)

    if [ -z $name ];
        then
            exit 0
    fi

    if [ -z $TMUX ];
        then
            tmux new-session -s $name -c $project_dir
        else
            tmux new-session -d -s $name -c $project_dir
            tmux switch -t $name
    fi
}

if [ -z $1 ];
    then
        create_session;
    else
        if [ $1 = "r" ]; then
            refresh_projects_list
        elif [ $1 = "a" ]; then
          add_project_manually $2
        else
            print_usage
        fi
fi
            
