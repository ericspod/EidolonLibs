#! /bin/bash


for i in *.framework/
do
    lib=$i${i//.*}
    
    otool -L $lib|grep \@executable_path|while read i
    do
        i=${i// \(*}
        install_name_tool -change $i \@loader_path/..${i#\@executable_path/../Frameworks} $lib
    done
    
    otool -L $lib
done
