# EidolonLibs
Precompiled Libraries for Eidolon. 
These include shared libraries for supported platforms, Python eggs in the **python** directory, and other libraries/utilities.

## Updating

As a consequence of this repo always being used as a submodule in Eidolon, any changes here require the submodule SHA-1 value to be changed in the Eidolon repo and then updated. If this isn't done then the Eidolon checkout will continue to use the older version of this repo. To do the update, use this command in the Eidolon repo:

    git submodule foreach git pull origin master

## Building Eggs/Wheels

The **python** directory contains eggs or wheels for a number of libraries.
These were compiled by downloading the source for each and running the following command to produce the egg file:

    python setup.py bdist_egg
    
or wheel:

    python setupt.py bdist_wheel
    
Typically this is all that is necessary, although in some cases the **setup.py** file may need to be changed to use **setuptools**.

## IRTK

The **IRTK** directory contains the executables for Windows, Linux, and OSX which Eidolon currently uses from the Image Regitration Toolkit (https://github.com/BioMedIA/IRTK). 
Building instructions are found on the project's repository so there's no need to reproduce them here.
Soon these will be replaced with those from MIRTK (https://github.com/BioMedIA/MIRTK) which is the successor project, so this directory will shortly be replaced or become legacy.
Current a **MIRTK** is also included which provides some parallel functionality, specifically motion tracking. 

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
   * Cg_BINARY_REL should be set to where the cg.dll lives in the dependencies folder
   * Everything will be default be built, so to save time uncheck all of the plugins and components except the GL render system, the Cg plugin, and the overlay component. You should also unselect building tools and examples. If the Cg plugin doesn't show up, make sure the Cg binary paths are correct and then regenerate the config info.
 
 8. Generate the build information.
 
 9. Navigate in a shell to **build** and run **mingw32-make.exe**.
 
 10. Overwrite the files in **EidolonLibs/win64_mingw/bin** with those you've just built in **build/bin** and the files in **EidolonLibs/win64_mingw/lib** with those in **build/lib**.
 
 11. The include files shouldn't need changing, but these you would copy from the **ogre** directory into **EidolonLibs/win64_mingw/include/OGRE**, throwing in the **OgreBuildSettings.h** file from **build** so that the compilation configuration is kept.
 
 
#### Building Ogre with MinGW 64-bit Supplied with Anaconda

Building Ogre with the MinGW specified above may require a few code tweaks.
Read the following, the first is a step guide and the second is the changes to Ogre code necessary to get MinGW to work:
 * http://www.ogre3d.org/tikiwiki/tiki-index.php?page=Building+Ogre+with+boost+1.50+upwards+and+MinGW
 * http://www.ogre3d.org/tikiwiki/tiki-index.php?page=TDM+MinGW64+build+guide
 
    
### osx

This is the directory for OS X 10.8 and up.
Normally the libraries here and Eidolon itself is compiled on OS X 10.8 with the system Python to ensure compatibility with later OS versions.
There's been problems of compiling on later OS versions and then not working on older, there are still users tied to older OS versions for technical reasons so these need support.

The following instructions are for compiling in OSX using Xcode and CMake, however precompiled builds for Ogre 1.9 are available on the Ogre website and these suffice just fine, precompiles for later builds may be available from other developers as well.

 1. Install the Cg framework from nVidia: https://developer.nvidia.com/cg-toolkit
 
 2. Ogre is compiled by following the instructions for Windows starting from step 4 assuming everything is installed, with the following changes:
   * CMAKE_CXX_FLAGS = -F/Library/Frameworks
   * The Cg include directory should point to that in the included **Dependencies/src/Cg/include** directory
   * The Cg_LIBRARY_* values should all be /Library/Frameworks/Cg.framework
   
 3. Move the compiled frameworks into the **osx/bin** directory. The Cg framework is copied from the one installed by the installer, so just keep this.

### linux

This is the directory for Linux (formerlly just Ubuntu 12.04) libraries, this is expected to work for other versions of Ubuntu and other current distros.
The system Ogre for some distros isn't new enough to use so the included one is build separately using the current branch of Ogre.

 1. Some extra packages are needed:
   * libxaw7-dev
   * nvidia-cg-toolkit
   * libxrandr-dev
   * Dev packages for your OpenGL, which if you're using MESA will be libglu1-mesa-dev and its dependencies

 2. Follow the instructions for Windows starting from step 4 assuming everything is installed
 
 3. Move the compiled shared objects into the **linux/lib** directory. The **libCg.so** file is copied from the system so installing the Cg package isn't strictly necessary 
 

