# MMC

Module Manangement Console; a `NodeJS` program to manage VLBC & CBUS modules

Being based on NodeJS, it is a cross platform application, running on windows, linux & MacOS

There are essentially two components:

1. **The MMC-Server** - this handles all the communications to&from the module, has the majority of the logic, and also starts a it's own simple web server to host the web pages for the MMC-Client. For the web pages, a pre-built version of the MMC-Client is embedded into the MCC-Server, so only the MMC-Server is needed to be distributed
2. **The MMC-Client**, which is a web based application that provides the user interface, and uses web sockets to talk to the MMC-Server to get its data

Once run, the program will start the client on the same machine in the default browser, but like any other web server, it will accept connections from browsers on other machines on the same network - no need to load software on those machines.

In principal, another machine could be a tablet or mobile on the same network, but very little testing has been done for this situation

# To run the application using NodeJS (all platforms)

## Requirements

The following is needed to run the application from the github project

1. Node.js - see the Node.js section in the [Installation Document](InstallAndRun/README.md#nodejs) for more information
2. This application - see the [Installation Document](InstallAndRun/README.md) for more information
3. A connection to the device to be tested  - see Connection section

# Installation

Please see the [Installation Documentation](InstallAndRun/README.md) for more information

## Connection

On startup, a dialog will be displayed, expecting a layout to be selected before the 'proceed' option can be clicked.

A default layout will be created if none exist, but it's recommended that an appropriately named layout is created. Multiple layouts can be created, each with their own configuration & data (names & groups etc..).

By default, layouts will be set to 'auto', which will attempt to automatically find a CANUSB or CANUSB4 device connected via USB, and then use that to connect to the CANBUS network.

There is an INFO button on the startup dialog that provides more information on the options that can be selected

## Execution:

Execution of the app depends upon how you installed the application:
1. If you installed via `npm install -g ...`, you should be able to simply execute `mmcserver`
2. If you have a local clone of the github repository, then you'll need to execute `npm start` from within the root directory of your local copy (clone)

The program will open a web page using the default web browser, and the 'startup' dialog displayed as mentioned above

## Environment Variables

Certain functionallity of the application may be "controlled" if certain environment variables are set.

Note: Setting of environment variables is dependant upon your OS, so if you intend to use theses vars you may wish to investigate the best method for your OS and use-case

e.g. For a `bash` shell on a linux or Mac OS, you could simply set the var when you launch the app (e.g. `MMC_SERVER_HTTP_PORT=3100) or, for a permanent solution, you could specify it in your `${HOME}/.bashrc` file (there are lots of options)

For Windows, you'll probably want to set it in `System Properties->Advanced->Environment Variables...` Hint: click the `Start` button and type `environment properties`

### `MMC_SERVER_HTTP_PORT`

By default, the embedded webserver (and the browser) will use port `3000`, but this can be overridden by setting this variable to a different integer value.

Obviously, you'll need to select a port that is not currently in use by another process, and you should also ensure it is outside of the range `0-1024`, as that range requires elevated privileges

# 'user' data

Data entered by the user, such as the user configured layouts and the associated names & groups, are stored independently of the application, so upgrading or moving the application won't lose this information
See the [User Data](UserData.md) page for information about how user data is stored

# Testing

For testing purposes, there is a [software simulation of a CBUS network](https://github.com/david284/CbusNetworkSimulator) available, again using the 'network' option,
which avoids the need for any other physical hardware

This application provides a simulation of multiple modules on a VLCB network, and has been used to test operation of this conformance test

