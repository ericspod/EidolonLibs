#! /bin/bash


for i in *.framework/
do
    lib=$i${i//.*}
    echo $lib
    
    otool -L $lib|grep \@executable_path|while read i
    do
        i=${i// \(*}
        #install_name_tool -change $i \@loader_path/..${i#\@executable_path/../Frameworks} $lib
    done
    
    #install_name_tool -change @loader_path/../Ogre.framework/Versions/1.10.0/Ogre @loader_path/../Ogre.framework/Ogre $lib
    otool -L $lib
done
