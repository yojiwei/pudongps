@rem *************************************************************************
@rem This script is used to install WebLogic Server as a service for the 
@rem domain in the current working directory.  This script simply sets the 
@rem SERVER_NAME variable to your server name then calls the installSvc.cmd 
@rem script under %WL_HOME%\server\bin.
@rem
@rem To create your own domain script, all you need to set is 
@rem SERVER_NAME, then call %WL_HOME%\server\bin\installSvc.cmd
@rem
@rem Other variables that installService takes are:
@rem
@rem WLS_USER     - cleartext user for server startup
@rem WLS_PW       - cleartext password for server startup
@rem STARTMODE    - true for production mode servers, false for 
@rem                development mode
@rem JAVA_OPTIONS - Java command-line options for running the server. (These
@rem                will be tagged on to the end of the JAVA_VM and MEM_ARGS)
@rem JAVA_VM      - The java arg specifying the VM to run.  (i.e. -server, 
@rem                -hotspot, etc.)
@rem MEM_ARGS     - The variable to override the standard memory arguments
@rem                passed to java
@rem
@rem For additional information, refer to the WebLogic Server Administration 
@rem Guide (http://e-docs.bea.com/wls/docs70/adminguide/startstop.html).
@rem *************************************************************************

echo off
SETLOCAL

@rem USERDOMAIN_HOME is preset to the domain directory.
set USERDOMAIN_HOME=C:\forum\forum

@rem Set SERVER_NAME to the name of the server you wish to start up.
set SERVER_NAME=forum

@rem Set DOMAIN_NAME to the name of the server you wish to start up.
set DOMAIN_NAME=forum

@rem Set WLS_USER equal to your system username and WLS_PW equal  
@rem to your system password for no username and password prompt 
@rem during server startup.  Both are required to bypass the startup
@rem prompt.
set WLS_USER=xyworker
set WLS_PW=

@rem Set Production Mode.  When this is set to true, the server starts up in 
@rem production mode.  When set to false, the server starts up in development 
@rem mode.  If it is not set, it will default to false.
set STARTMODE=

@rem Set JAVA_OPTIONS to the java flags you want to pass to the vm. i.e.: 
@rem set JAVA_OPTIONS=-Dweblogic.attribute=value -Djava.attribute=value
set JAVA_OPTIONS=

@rem Set JAVA_VM to the java virtual machine you want to run.  For instance:
@rem set JAVA_VM=-server
set JAVA_VM=

@rem Set MEM_ARGS to the memory args you want to pass to java.  For instance:
@rem set MEM_ARGS=-Xms32m -Xmx200m
set MEM_ARGS=

@rem Call Weblogic Server service installation script 
call "C:\bea\weblogic700\server\bin\installSvc.cmd"

ENDLOCAL
