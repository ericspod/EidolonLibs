#! /bin/bash

#install_name_tool -change @executable_path/../Frameworks/Ogre.framework/Versions/1.10.0/Ogre @loader_path/../Ogre.framework/Versions/1.10.0/Ogre OgreOverlay.framework/OgreOverlay
#install_name_tool -change @executable_path/../Frameworks/OgreOverlay.framework/Versions/1.10.0/OgreOverlay @loader_path/../OgreOverlay.framework/Versions/1.10.0/OgreOverlay OgreOverlay.framework/OgreOverlay

for i in *.framework/;do
    lib=$i${i//.*}
    
    otool -L $lib|grep \@executable_path|while read i
    do
        i=${i// \(*}
        install_name_tool -change $i \@loader_path/..${i#\@executable_path/../Frameworks} $lib
    done
done
