# Project Title

Provide an introductory paragraph, describing:

* What your project does
* Why people should consider using your project
* Link to project home page

## Table of Contents

[About the Project](#about-the-project)  
[Project Status](#project-status)  
[Getting Started](#getting-started)  
- [Requirements](#requirements)  
- [Getting the Source](#getting-the-source)  
- [Building](#building)  
- [Testing](#testing)
  
[Documentation](#documentation)  
[Contributing](#contributing)  
[Authors](#authors)  
[License](#license)  
[Acknowledgments](#acknowledgements)  

# About the Project

Here you can provide more details about the project
* What features does your project provide?
* Short motivation for the project? (Don't be too long winded)
* Links to the project site

```
Show some example code to describe what your project does
Show some of your APIs
```

**[Back to top](#table-of-contents)**

# Project Status

Describe the current release and any notes about the current state of the project. Examples: currently compiles on your host machine, but is not cross-compiling for ARM, APIs are not set, feature not implemented, etc.

**[Back to top](#table-of-contents)**

## Getting Started

### Requirements

This project uses a fork of [Embedded Artistry's standard CMake build system](https://embeddedartistry.com/fieldatlas/embedded-artistrys-standardized-cmake-build-system/) which is included here as the submodule `cmake`.

At a minimum you will need:

* [`git-lfs`](https://git-lfs.github.com), which is used to store binary files in this repository
* [CMake](#cmake-build-system) is the build system
* Some kind of compiler for your target system.
    - This repository has been tested with:
        - gcc-7, gcc-8, gcc-9
        - arm-none-eabi-gcc
        - Apple clang
        - Mainline clang

#### git-lfs

This project stores some files using [`git-lfs`](https://git-lfs.github.com).

To install `git-lfs` on Linux:

```
sudo apt install git-lfs
```

To install `git-lfs` on OS X:

```
brew install git-lfs
```

Additional installation instructions can be found on the [`git-lfs` website](https://git-lfs.github.com).

#### CMake Build System

The official way to install CMake is to use the pre-compiled binaries and installers on the [CMake download page](https://cmake.org/download/). You can also [compile CMake from source](https://cmake.org/install/). CMake can also be installed through popular package managers, although they may be slightly behind the latest release available on the website.

You can install CMake with `apt` on Linux/WSL:

```
sudo apt-get install cmake
```

> **Note:** Does this not work? You may need to add an [apt repository](https://apt.kitware.com/).

OS X users can install CMake using [Homebrew](homebrew):

```
brew install cmake
```

You can also use Python's `pip` to install CMake:

```
$ pip3 install cmake
```

Make is the default backend for CMake, but our Makefile interface defaults to Ninja. Ninja is similar in purpose to Make, but provides better performance. 

To install Ninja on Linux & WSL:

```
$ sudo apt install ninja-build
```

To install on OSX:

```
$ brew install ninja
```


**[Back to top](#table-of-contents)**

### Getting the Source

This project uses [`git-lfs`](https://git-lfs.github.com), so please install it before cloning. If you cloned prior to installing `git-lfs`, simply run `git lfs pull` after installation.

This project is hosted on GitHub. You can clone the project directly using this command:

```
git clone --recursive git@github.com:daleonpz/cmake-template.git
```

If you don't clone recursively, be sure to run the following command in the repository or your build will fail:

```
git submodule update --init
```

**[Back to top](#table-of-contents)**

### Building

If Make is installed, the library can be built by issuing the following command:

```
make
```

This will build all targets for your current architecture.

You can clean builds using:

```
make clean
```

You can eliminate the generated `buildresults` folder using:

```
make distclean
```

You can also use  `CMake` directly for compiling.

Create a build output folder:

```
cmake -B buildresults
```

And build all targets by running

```
ninja -C buildresults
```

Cross-compilation is handled using CMake toolchain files. Example files are included in the [`cmake/toolchains/cross`](cmake/toolchains/cross/) folder. You can write your own cross files for your specific processor by defining the toolchain, compilation flags, and linker flags. These settings will be used to compile the project.

Cross-compilation must be configured using the CMake command when creating the build output folder. For example:

```
cmake -B buildresults -DCMAKE_TOOLCHAIN_FILE=cmake/toolchains/cross/cortex-m3.cmake
```

Following that, you can run `make` (at the project root) or `ninja` to build the project.

Tests will not be cross-compiled. They will only be built for the native platform.

**[Back to top](#table-of-contents)**

### Testing

The tests for this project are written in CMocka and Catch, which are included as external dependencies and does not need to be installed on your system. You can run the tests by issuing the following command:

```
make test
```

By default, test results are generated for use by the CI server and are formatted in JUnit XML. The test results XML files can be found in `buildresults/test/`.

**[Back to top](#table-of-contents)**

## Documentation

Documentation can be built locally by running the following command:

```
make docs
```

Documentation can be found in `buildresults/docs`, and the root page is `index.html`.

**[Back to top](#table-of-contents)**

## Contributing

If you are interested in contributing to this project, please create a pull request.

## Authors

* Original authors: **[Phillip Johnston](https://github.com/phillipjohnston)**
* Maintained and extended by **[Daniel Paredes (daleonpz)](https://github.com/daleonpz)**

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for full details.

Copyright © 2020 Embedded Artistry LLC.  
Modified and maintained by **[Daniel Paredes (daleonpz)](https://github.com/daleonpz)**.

## Acknowledgments

* Thanks to the original authors: Phillip Johnston and Embedded Artistry LLC.
  
**[Back to top](#table-of-contents)**

