#!/usr/bin/env bash

# Store the STDOUT of fzf in a variable
selection=$(sudo find ${current_directory} -type d | fzf --multi --height=80% --border=rounded \
--preview='tree -C {}' --preview-window='60%,border-rounded' \
--prompt='Dirs > ' \
--bind='del:execute(rm -ri {+})' \
--bind='ctrl-p:toggle-preview' \
--bind='ctrl-d:change-prompt(Dirs > )' \
--bind='ctrl-d:+reload(find -type d)' \
--bind='ctrl-d:+change-preview(tree -C {})' \
--bind='ctrl-d:+refresh-preview' \
--bind='ctrl-f:change-prompt(Files > )' \
--bind='ctrl-f:+reload(find -type f)' \
--bind='ctrl-f:+change-preview(batcat --color=always --style=header,grid --line-range :300 {})' \
--bind='ctrl-f:+refresh-preview' \
--bind='ctrl-a:select-all' \
--bind='ctrl-x:deselect-all' \
--header '
CTRL-D to display directories | CTRL-F to display files
CTRL-A to select all | CTRL-x to deselect all
ENTER to edit | DEL to delete
CTRL-P to toggle preview
'
)

# Determine what to do depending on the selection
if [ -z "$selection" ]; then
    :
elif [ -d "$selection" ]; then
    cd "$selection" || exit
else
    eval "$EDITOR $selection"
fi


# Determine what to do depending on the selection
if [ -z "$selection" ]; then
    :
elif [ -d "$selection" ]; then
    cd "$selection" || exit
else
    if [[ $selection == *$'\n'* ]]; then
        # If string is a multiline selection including \n then replace it by spaces
        cleaned_string=$(echo -n "${selection}" | tr '\n' ' ')
        eval "$EDITOR $cleaned_string"
    else
        # Single Selection
        eval "$EDITOR $selection"
    fi
fi