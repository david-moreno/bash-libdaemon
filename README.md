# bash-libdaemon

A Bash library for daemonizing a script

Install
-------

You can clone this repository or download it as a zip file. To clone:

    git clone https://github.com/david-moreno/bash-libdaemon.git
    cd bash-libdaemon
    sudo make install

Uninstall
---------

Using the cloned/unzipped directory:

    cd bash-libdaemon
    sudo make uninstall

Usage
-----

#### dmn_get_pidf_dir
Returns the current PID file directory

The default is **/var/run**


#### dmn_set_pidf_dir *dir*
Sets the current PID file directory

**dir** must be an absolute path

The script must have write permissions on **dir**


#### dmn_get_pidf_name
Returns the current PID file name


#### dmn_set_pidf_name *name*
Sets the current PID file name

The default is **[script_name].pid**


#### dmn_pidf_create
Creates the PID file


#### dmn_pidf_exists
Determines if an older PID file exists


#### dmn_pidf_own
Determines if the PID file has the same PID than the current script


#### dmn_pidf_delete
Deletes the pid file


#### dmn_start *main* *terminate*
Daemonizes the script

The function **main** will be executed in an endless loop

The function **terminate** will be executed on SIGINT SIGHUP SIGTERM or SIGKILL

PID file deleting and the *exit* call are added automatically

Example
-------

This script creates the PID file **foo.pid** on the current working directory, checks if an existing PID file exists and runs the daemonized script

```bash
#!/bin/bash

source "/usr/lib/bash/libdaemon"

NAME="foo.pid"
DIR=`pwd`
LOG="$DIR/test.log"

#This function will be executed on SIGINT SIGHUP SIGTERM or SIGKILL
#The PID file deleting and the 'exit' call are added automatically.
function term {
	echo -e "\n* $0: Exiting">>$LOG
}

#This function will be executed on and endless loop.
function main {
	echo -n ".">>$LOG
	sleep 1
}

#Please note that the directory *must* be an absolute path.
dmn_set_pidf_name $NAME
dmn_set_pidf_dir $DIR

#Checks if a PID file already exists.
(( `dmn_pidf_exists` )) && {
	echo -e "\n* $0: pidfile exists, exiting">>$LOG
	exit
}
dmn_pidf_create

echo -e "\n* $0: Initiating">>$LOG

#Daemonizes the script.
dmn_start main term
```
