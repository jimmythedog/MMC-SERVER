# MMC-SERVER Installation

There are a few ways of installing `MMC-SERVER` to your machine; please choose a method that suits your use case.

## Scripts

There are dedicated scripts for Windows and Linux that will install the Node.js pre-requisite, and clone the git repository to your machine (and, as `git` is required for this method, they will also install `git`); there is also the option of performing a [manual install](#manual)

### Windows

There is a dedicated [Windows install script](Windows/installMMC.cmd). You may download this to your local machine and "Run as Administrator". After confirming the execution at the Windows prompts the script will check and install NodeJS, Git and MMC. It will also create MMC link icons on the Desktop and in the start menu to run MMC.

### Linux

There is a linux installer available, details here: [linux installer](Linux/linuxInstaller.md)

## Manual

If you are not using the scripts above, perform the following steps in your chosen method

_**Note**_: You will need to have `Node.js` installed; if `node -v` or `npm -v` do not execute cleanly & show the versions for each, then you will need to [install Node.js](#pre-requisites)

### Git clone

* This method requires that you have `git` installed
* It is the best way for people who wish to contribute changes to the repository, but will also work for other users
* See the [Git Cloning](GitCloning.md) page for more information about cloning a repository
* Open up a terminal
  * From a suitable directory on your machine, execute `git clone git@github.com:david284/MMC-SERVER.git [TARGET_DIR]`
  * Move into the cloned directory (either `MMC-SERVER`, or the specified `TARGET_DIR]`)
  * Execute `npm install` to download & install the node modules required by `MMC-SERVER`
* Execute `npm start` to start the app

### Source code tarball

* This method does not require `git` to be installed
* It is probably suited to people who will not be contributing code changes, and wish to store a copy of the code in a directory of their choosing
* Obtain the source code:
  * On Windows:
    * Point your browser at the [MMC-SERVER download](https://github.com/david284/MMC-SERVER/archive/refs/heads/main.zip) and save the zip file
    * Open up the downloaded zip file and extract it to a directory of your choice
  * On Linux and MacOS:
    * Change directory a suitable location, and execute `mkdir MMC-SERVER && curl -fsSLo- https://github.com/david284/MMC-SERVER/archive/refs/heads/main.zip | tar xf - -C MMC-SERVER --strip-components=1` (or substitute `MMC-SERVER` with a a directory of your choice)
  * Move into your chosen directory (e.g. `MMC-SERVER`)
  * Execute `npm install` to download & install the node modules required by `MMC-SERVER`
* Execute `npm start` to start the app

### npm install

* This method also does not require `git`
* Is probably suited to people who do not wish to contribute changes
* On Linux and MacOS:
  * In a terminal:
    * Execute `sudo npm install -g @jimmythedog/mmc-server@next` TODO: the `@jimmythedog` name will change in the future, also @next won't be required for main releases
    * Execute `mmcserver` to start the app
* On Windows:
  * Open up a command shell (with Administrator privileges):
    * Execute `npm install -g @jimmythedog/mmc-server@next` TODO: the `@jimmythedog` name will change in the future, also @next won't be required for main releases
  * Open up a command shell (without Administrator privileges):
    * Execute `mmcserver` to start the app

# Pre-requisites

## Node.js

If you are using the provided [script](#Scripts) method to install `MMC-SERVER`, you can skip this section, as the scripts will install Node.js for you

Otherwise, perform the steps in the appropriate section for your platform below:

### Windows

1. Point your browser to the [official Node.js download site](https://nodejs.org/en/download)
1. Choose the latest `(LTS)` version from the `Get Node.js` dropdown at the top of the page
1. Ignore the script instructions at the top, and use the prebuilt images just below the script instructions
1. In the `Or get a prebuilt Node.js for` section, choose the correct OS and Arch options
1. Then click on the `Windows Installer (.msi)` button to download the installer
1. Once downloaded, execute the file and follow the instructions

### MacOS

1. Point your browser to the [official Node.js download site](https://nodejs.org/en/download)
1. Choose the latest `(LTS)` version from the `Get Node.js` dropdown at the top of the page
1. Ignore the script instructions at the top, and use the prebuilt images just below the script instructions
1. In the `Or get a prebuilt Node.js for` section, choose the correct OS and Arch options
1. Once downloaded, execute `sudo installer -pkg [PATH_TO_DOWNLOADED_PKG] -target /`

### Linux

1. It is probably easier on Linux platforms to use the bult in package manager;. e.g. on Debian derived platforms (`Ubuntu`, `Mint` etc.) use `apt` 
1. `sudo apt install npm`

## Test pre-requisites

Within a terminal, execute the following:

1. `node -v` and ensure that a version is returned without any errors
1. `npm -v` should also return version (will be different the the above version) 

