project_dir=$(cat ~/.projects | fzf) &&
name=$(basename $project_dir)

if [ -z $TMUX ];
    then
        tmux new-session -s $name -c $project_dir;
    else
        tmux new-session -d -s $name -c $project_dir
        tmux switch -t $name;
fi



