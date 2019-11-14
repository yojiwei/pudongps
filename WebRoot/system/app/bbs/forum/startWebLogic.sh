#!/bin/sh
# ****************************************************************************
# This script is used to start WebLogic Server for the domain in the current 
# working directory.  This script simply sets the SERVER_NAME variable 
# and calls the startWLS.sh script under ${WL_HOME}/server/bin.
#
# To create your own start script for your domain, all you need to set is 
# SERVER_NAME, then call ${WL_HOME}/server/bin/startWLS.sh
#
# Other variables that startWLS takes are:
#
# WLS_USER       - cleartext user for server startup
# WLS_PW         - cleartext password for server startup
# STARTMODE      - Set to true for production mode servers, false for 
#                  development mode
# JAVA_OPTIONS   - Java command-line options for running the server. (These
#                  will be tagged on to the end of the JAVA_VM and MEM_ARGS)
# JAVA_VM        - The java arg specifying the VM to run.  (i.e. -server, 
#                  -hotspot, etc.)
# MEM_ARGS       - The variable to override the standard memory arguments
#                  passed to java
#
# For additional information, refer to the WebLogic Server Administration Guide
# (http://e-docs.bea.com/wls/docs70/adminguide/startstop.html).
# ****************************************************************************

# Set SERVER_NAME to the name of the server you wish to start up.
SERVER_NAME=forum

# Set WLS_USER equal to your system username and WLS_PW equal  
# to your system password for no username and password prompt 
# during server startup.  Both are required to bypass the startup
# prompt.
WLS_USER=
WLS_PW=

# Set Production Mode.  When this is set to true, the server starts up in 
# production mode.  When set to false, the server starts up in development 
# mode.  If it is not set, it will default to false.
STARTMODE=""

# Set JAVA_OPTIONS to the java flags you want to pass to the vm.  If there 
# are more than one, include quotes around them.  For instance: 
# JAVA_OPTIONS="-Dweblogic.attribute=value -Djava.attribute=value"
JAVA_OPTIONS="-Dweblogic.security.SSL.trustedCAKeyStore=C:/bea/weblogic700/server/lib/cacerts"

# Set JAVA_VM to the java virtual machine you want to run.  For instance:
# JAVA_VM="-server"
JAVA_VM=""

# Set MEM_ARGS to the memory args you want to pass to java.  For instance:
# MEM_ARGS="-Xms32m -Xmx200m"
MEM_ARGS=""

. "C:/bea/weblogic700/server/bin/startWLS.sh"
