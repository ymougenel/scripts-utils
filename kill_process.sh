#!/bin/bash

program_name=$1


# TODO: handle parameters properly
if [ "$2" = "force" ];then
  force_killing=true
else
  force_killing=false
fi
echo "***********  kill process launched for: $program_name (force=$force_killing)************* "
ps_filtered=$()

IFS=$'\n' # make newlines the only separator
for line in $(ps aux | grep $program_name); do
    kill_it=true
    echo ""
    echo "> $line"
    if [ ! "$force_killing" = true ]; then
        echo "kill it? (Y/n)"
        echo "... .."
        read kill_intention
        if [ "$kill_intention" = "n" ]; then
          kill_it=false;
        fi
    fi

    if [ "$kill_it" = true ]; then
      process_id=$(echo $line | cut -d" " -f5)
      echo "killing process_id $process_id"
      kill -9 "$process_id"
    fi
done
