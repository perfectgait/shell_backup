#!/bin/sh

ORIGINAL_DIR=CHANGE_ME
BACKUP_DIR=CHANGE_ME

if ! [ -d $ORIGINAL_DIR ]
then
    echo "$ORIGINAL_DIR does not exist"
    exit 1
fi

if ! [ -r $ORIGINAL_DIR ]
then
    echo "$ORIGINAL_DIR is not readable by the current user"
    exit 1
fi

if ! [ -d $BACKUP_DIR ]
then
    echo "Creating $BACKUP_DIR"
    mkdir -p $BACKUP_DIR
fi

if [ "$(ls -A $ORIGINAL_DIR)" ]
then
    echo "Backing up files"

    for file in $ORIGINAL_DIR/*
    do
        if [ -f $file ] && [ -r $file ]
        then
            echo "Copying ${file##*/}"
            cp -fpu $file $BACKUP_DIR/${file##*/}
        else
            echo "Skipping ${file##*/}"
        fi
    done

#    cp -fpru $ORIGINAL_DIR/* $BACKUP_DIR
else
    echo "$ORIGINAL_DIR is empty, skipping"
fi