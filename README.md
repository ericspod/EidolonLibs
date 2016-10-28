# EidolonLibs
Precompiled Libraries for Eidolon. 
These include shared libraries for supported platforms, Python eggs in the **python** directory, and other libraries/utilities.

## Building Eggs

The **python** directory contains eggs for a number of libraries.
These were compiled by downloading the source for each and running the following command to produce the egg file:

    python setup.py bdist_egg
    
Typically this all that is necessary, although in some cases the **setup.py** file may need to be changed to use **setuptools**.

## Building Platform Directories

### win64_mingw

This is the directory for windows libraries build with the MinGW installed into Anaconda.
All that needs to be here are Ogre3D libraries and their dependencies along with header files.
Mercurial, CMake, Anaconda, and Pip are necessary to build, Cygwin is not but is handy anyway.

 1. Install Cygwin from http://www.cygwin.org first, making sure to include **make** with the installation. Modify your config files to ensure the Anaconda executables are topmost in your **PATH**. 
 
 **OR**
 
 Use the Windows shell or PowerShell to invoke the commands in the next 2 steps, making sure Anaconda executables are accessible. Cygwin isn't necessary but is really handy.

 2. Next pip must be installed, go to https://pip.pypa.io/en/latest/installing.html to get the get-pip.py script and run it in your terminal. 

 3. Install MinGW with the following:

        pip install -i https://pypi.anaconda.org/carlkl/simple mingwpy
        
 4. Checkout Ogre using Mercurial
 
        hg clone https://bitbucket.org/sinbad/ogre/
        
 or download the the whole repository as an archive.
 We'll call the directory you checked this out/unzip into **ogre** from here on.
 
 5. Checkout or download the dependencies directory
 
        hg clone https://bitbucket.org/cabalistic/ogredeps/
 
 Move this directory to **ogre/Dependencies**
        
 6. Run CMake or CMake-gui with the checkout directory as the **Source Code** directory.
 Choose a directory somewhere else for the output directory (we'll call this **build** from here on)
 
 7. Configure and generate the build information.
 
 8. Navigate in a shell to **build** and run **mingw32-make.exe**.
 
 9. Overwrite the files in **EidolonLibs/win64_mingw/bin/Release** with those you've just built in **build**.
 
 10. The include files shouldn't need changing, but these you would copy from the **ogre** directory into **EidolonLibs/win64_mingw/include/OGRE**, throwing in the **OgreBuildSettings.h** file from **build** so that the compilation configuration is kept.
