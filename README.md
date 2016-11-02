# EidolonLibs
Precompiled Libraries for Eidolon. 
These include shared libraries for supported platforms, Python eggs in the **python** directory, and other libraries/utilities.

## Building Eggs

The **python** directory contains eggs for a number of libraries.
These were compiled by downloading the source for each and running the following command to produce the egg file:

    python setup.py bdist_egg
    
Typically this is all that is necessary, although in some cases the **setup.py** file may need to be changed to use **setuptools**.

## Building Platform Directories

### win64_mingw

This is the directory for Windows 7/8/10 libraries build with the MinGW installed into Anaconda.
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
 
 Move this directory to **ogre/Dependencies**.
        
 6. Run CMake or CMake-gui with the checkout directory as the **Source Code** directory.
 Choose a directory somewhere else for the output directory (we'll call this **build** from here on) and create the configuration info.
 
 7. A number of settings need to be changed for the correct building data to be made (cmake-gui makes this easier):
   * CMAKE_BUILD_TYPE = Release
   * Cg_BINARY_REL and Cg_BINARY_DBG should be set to where the cg.dll lines in the dependencies folder
   * Everything will be default be built, so to save time uncheck all of the plugins and components except the GL render system, the Cg plugin, and the overlay component. You should also unselect building tools and examples. If the Cg plugin doesn't show up, make sure the Cg binary paths are correct and then regenerate the config info.
 
 8. Generate the build information.
 
 9. Navigate in a shell to **build** and run **mingw32-make.exe**.
 
 10. Overwrite the files in **EidolonLibs/win64_mingw/bin** with those you've just built in **build/bin** and the files in **EidolonLibs/win64_mingw/lib** with those in **build/lib**.
 
 11. The include files shouldn't need changing, but these you would copy from the **ogre** directory into **EidolonLibs/win64_mingw/include/OGRE**, throwing in the **OgreBuildSettings.h** file from **build** so that the compilation configuration is kept.
 
    
### osx

This is the directory for OS X 10.8 and up.
Normally the libraries here and Eidolon itself is compiled on OS X 10.8 with the system Python to ensure compatibility with later OS versions.
There's been problems of compiling on later OS versions and then not working on older, there are still users tied to older OS versions for technical reasons so these need support.

The following instructions are for compiling in OSX using Xcode and CMake, however precompiled builds for Ogre 1.9 are available on the Ogre website and these suffice just fine, precompiles for later builds may be available from other developers as well.

 1. Install the Cg framework from nVidia: https://developer.nvidia.com/cg-toolkit
 
 2. Ogre is compiled by following the instructions for Windows starting from step 2 assuming everything is installed, with the following changes:
   * CMAKE_CXX_FLAGS = -F/Library/Frameworks
   * The Cg include directory should point to that in the included **Dependencies/src/Cg/include** directory
   * The Cg_LIBRARY_* values should all be /Library/Frameworks/Cg.framework
   
 3. Move the compiled frameworks into the **osx/bin** directory. The Cg framework is copied from the one installed by the installer, so just keep this.

### ubuntu12

This is the directory for Ubuntu 12.04 libraries, although this might work for other versions of Ubuntu up to 14.04 but these haven't been tried.
The system Ogre isn't new enough to use so the included one is build separately using the 1.9 branch of Ogre.

### ubuntu14

This is the directory for Ubuntu 14.04 libraries, although 14.10 should also work.
Eidolon links with the system version of Ogre so there's not much in this directory.
The plugin shared objects are included for consistency but these are the same as those that are installed on the system.
To install the correct development libraries, run the following:

    sudo apt-get install libogre-1.9-dev


