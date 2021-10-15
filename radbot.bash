#!/bin/bash

# target is what we work on
target="$1"

# global config
source "$HOME/radbot/personal.conf"
export radbot_dir plugin_dir PATH TMPDIR logFile

oldCwd=$(pwd)

# cycle through the list of plugins
for plugin in $(ls $plugin_dir)
do
    echo now working with $plugin >> $logFile
    cd $plugin_dir/$plugin
   
    # read the plugin's config
    source "$plugin_dir/$plugin/${plugin}.conf"

    # check if the plugin is enabled
    if [ $enabled > 0 ] # enabled
    then
	# execute the "cmdline" variable
	#echo $cmdLine
	${plugin}.sh "$target" $logFile
    else # disabled
	echo $plugin is not enabled >> $logFile
    fi

    cd $oldCwd
    
done
