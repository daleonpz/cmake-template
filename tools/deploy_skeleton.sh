#!/bin/bash

USE_GIT=1
USE_SUBMODULES=1
CORE_FILES="docs src test tools .clang-format .clang-tidy BuildOptions.cmake CMakeLists.txt Makefile Packaging.cmake README.md"
GIT_FILES=".gitattributes .github .gitignore"
SUBMODULE_DIRS=("cmake")
SUBMODULE_URLS=("https://github.com/embeddedartistry/cmake-buildsystem.git")

# Parse optional arguments
while getopts gsh opt; do
  case $opt in
	g) USE_GIT=0
	   USE_SUBMODULES=0
	;;
	s) USE_SUBMODULES=0
	;;
	h) # Help
		echo "Usage: deploy_skeleton.sh [optio nal ags] dest_dir"
		echo "Optional args:"
		echo "	-g: Assume non-git environment and install submodule files directly."
		echo "	-s: Don't use SUBMODULE_DIRS, and copy files directly"
		exit 0
	;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

# Shift off the getopts args, leaving us with positional args
shift $((OPTIND -1))

# First positional argument is the destination folder that skeleton files will be installed to
DEST_DIR=$1
STARTING_DIR=$PWD

# Check to see if we're in tools/ or the project-skeleton root
CHECK_DIR=cmake
if [ ! -d "$CHECK_DIR" ]; then
	cd ..
	if [ ! -d "$CHECK_DIR" ]; then
		echo "This script must be run from the project skeleton root or the tools/ directory."
		exit 1
	fi
fi

# Adjust the destination directory for relative paths in case we changed directories
# This method still supports absolute directory paths for the destination
if [ ! -d "$DEST_DIR" ]; then
	if [ -d "$STARTING_DIR/$DEST_DIR" ]; then
		DEST_DIR=$STARTING_DIR/$DEST_DIR
	else
		echo "Destination directory cannot be found. Does it exist?"
		exit 1
	fi
fi

# Copy core skeleton files to the destination
cp -r $CORE_FILES $DEST_DIR

# Delete the deploy skeleton script from the destination
rm $DEST_DIR/tools/deploy_skeleton.sh

# Copy git files to the destination
if [ $USE_GIT == 1 ]; then
	cp -r $GIT_FILES $DEST_DIR
fi

# Manually copy submodule files
if [ $USE_SUBMODULES == 0 ]; then
	git submodule update --init --recursive
	cp -r ${SUBMODULE_DIRS[@]} $DEST_DIR
fi

## The following operations all take place in the destination directory
cd $DEST_DIR

# Initialize Submodules
if [ $USE_SUBMODULES == 1 ]; then
	cd $DEST_DIR
	for index in ${!SUBMODULE_URLS[@]}; do
		git submodule add ${SUBMODULE_URLS[$index]} ${SUBMODULE_DIRS[$index]}
	done
	git commit -m "Add submodules from project skeleton."
else
	find ${SUBMODULE_DIRS[@]} -name ".git*" -exec rm -rf {} \;
fi

# Commit Files
if [ $USE_GIT == 1 ]; then
	git add --all
	git commit -m "Initial commit of project skeleton files."
fi

# Push all changes to the server
if [ $USE_GIT == 1 ]; then
	git push || echo "WARNING: git push failed: check repository."
fi