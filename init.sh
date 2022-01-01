#!/bin/bash
echo "Running init.sh script..."
DIRECTORIES_ARRAY=("iwc/tomcat/conf" "iwc/tomcat/ignite_config" "iwc/tomcat/logs" "iwc/tomcat/licensing") 
for d in "${DIRECTORIES_ARRAY[@]}"
do
    SOURCE_PATH=$(pwd)
    TARGET_PATH=/data
    #STEP 1: Creates directory if not already exists in the orginial location, otherwise STEP 2 would be unable to move and STEP 3 wouldn't have a folder to link.
    if [ ! -e "$SOURCE_PATH/$d" ] ; then
        #echo "Creating $SOURCE_PATH/$d"
        mkdir -p "./$d"
    fi
    #STEP 2: If directory from DIRECRTORIES_ARRAY not exists in the persistent storage location, create folder and move it.
    if [ ! -e "$TARGET_PATH/$d" ] ; then
        mkdir -p $TARGET_PATH/$d
        mv "$SOURCE_PATH/$d" "$TARGET_PATH/$(dirname $d)"
    fi
    #STEP 3: Removes specified directories from orginial location to be able to symbolic link them.
    if [ -e "$TARGET_PATH/$d" ] ; then
        rm -rf $SOURCE_PATH/$d
        ln --symbolic "$TARGET_PATH/$d" $SOURCE_PATH/$(dirname $d)
    fi
done