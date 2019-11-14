#!/bin/sh
# ****************************************************************************
# This script is used to start a managed WebLogic Server for the domain in the 
# current working directory.  This script reads in the SERVER_NAME and 
# ADMIN_URL as positional parameters, sets the SERVER_NAME variable, then 
# calls the startWLS.sh script under ${WL_HOME}/server/bin.
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
SERVER_NAME=
ADMIN_URL=

# Set WLS_USER equal to your system username and WLS_PW equal  
# to your system password for no username and password prompt 
# during server startup.  Both are required to bypass the startup
# prompt.
WLS_USER=
WLS_PW=

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

usage()
{
  echo "Need to set SERVER_NAME and ADMIN_URL environment variables or specify"
  echo "them in command line:"
  echo 'Usage: ./startManagedWebLogic.sh [SERVER_NAME] [ADMIN_URL]'
  echo "for example:"
  echo './startManagedWebLogic.sh managedserver1 http://localhost:7001'
  exit 1
}

# Check for variables SERVER_NAME and ADMIN_URL
# SERVER_NAME and ADMIN_URL must by specified before starting a managed server,
# detailed information can be found at http://e-docs.bea.com/wls/docs70/adminguide/startstop.html.
if [ ${#} = 0 ]; then
  if [ "x${SERVER_NAME}" = "x" -o "x${ADMIN_URL}" = "x" ]; then
    usage
  fi
elif [ ${#} = 1 ]; then
  SERVER_NAME=${1}
  if [ "x${ADMIN_URL}" = "x" ]; then
    usage
  fi
elif [ ${#} = 2 ]; then
  SERVER_NAME=${1}
  ADMIN_URL=${2}
else
    usage
fi

. "C:/bea/weblogic700/server/bin/startWLS.sh"
