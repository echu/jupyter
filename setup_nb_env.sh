#!/usr/bin/env sh

echo "import os"
env |
while read x;
do
    key=$(echo $x | cut -d'=' -f1)
    val=$(echo $x | cut -d'=' -f2)

    if [ "$key" != "HOME" ]
    then
        echo "os.environ['$key'] = '$val'"
    fi
done

#import os
#os.environ[]=
