#! /bin/sh

print_usage() {
    echo "Use tpe to browse projects";
    echo "Use tpe r to refresh projects list";
}

refresh_projects_list() {
    find ~/Documents -type d -name .git | sed "s/.git//g" > ~/.projects;
}

create_session() {
    project_dir=$(cat ~/.projects | fzf) &&
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
        else
            print_usage
        fi
fi
            