#!/bin/bash

DIRECTORIES_ARRAY=("iwc/tomcat/conf" "iwc/tomcat/ignite_config" "iwc/tomcat/logs" "iwc/tomcat/licensing") 
for d in "${DIRECTORIES_ARRAY[@]}"
do
    SOURCE_PATH=$(pwd)
    TARGET_PATH=/data
    if [ ! -e "$SOURCE_PATH/$d" ] ; then
        #echo "Creating $SOURCE_PATH/$d"
        mkdir -p "./$d"
    fi
    if [ ! -e "$TARGET_PATH/$d" ] ; then
        mkdir -p $TARGET_PATH/$d
        mv "$SOURCE_PATH/$d" "$TARGET_PATH/$(dirname $d)"
    fi
    if [ -e "$TARGET_PATH/$d" ] ; then
        rm -rf $SOURCE_PATH/$d
        ln --symbolic "$TARGET_PATH/$d" $SOURCE_PATH/$(dirname $d)
    fi
done