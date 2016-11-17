#! /bin/bash

# Determine file directory (http://stackoverflow.com/a/246128)
function getFileDir() {
	src=$1
	while [ -h "$src" ]; do # resolve $src until the file is no longer a symlink
		dir="$( cd -P "$( dirname "$src" )" && pwd )"
		src="$(readlink "$src")"
		# if $src was a relative symlink, we need to resolve it relative to the path where the symlink file was located
		[[ $src != "/*" ]] && src="$dir/$src" 
	done
	dir="$( cd -P "$( dirname "$src" )" && pwd )"
	
	echo $dir
}

# directory of this script
export APPDIR=$(getFileDir "${BASH_SOURCE[0]}")

export PYTHONPATH=$APPDIR/src:$APPDIR/src/eidolon:$APPDIR/src/plugins
export PATH="$APPDIR/../Frameworks/Python.framework/Versions/2.7/bin:$PATH"

export DYLD_LIBRARY_PATH=$APPDIR
export DYLD_FRAMEWORK_PATH=$APPDIR/../Frameworks

python2.7 $APPDIR/main.py $@

