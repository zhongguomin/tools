#!/bin/bash

# clean env
DeleteFiles=(cscope.files cscope.in.out cscope.out cscope.po.out tags)
for DeleteFile in ${DeleteFiles[@]}; do
    if [ -f ${DeleteFile} ]; then
        echo "rm ${DeleteFile}"
        rm ${DeleteFile}
    fi
done

# cscope
find . -type f > cscope.files
cscope -bqk -i cscope.files

# tags
ctags -R *

echo "Make cscope, ctags sucessful ..."
