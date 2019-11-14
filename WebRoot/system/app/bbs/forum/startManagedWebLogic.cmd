@rem *************************************************************************
@rem This script is used to start a managed WebLogic Server for the domain in 
@rem the current working directory.  This script reads in the SERVER_NAME and 
@rem ADMIN_URL as positional parameters, sets the SERVER_NAME variable, then 
@rem calls the startWLS.cmd script under ${WL_HOME}/server/bin.
@rem
@rem Other variables that startWLS takes are:
@rem
@rem WLS_USER       - cleartext user for server startup
@rem WLS_PW         - cleartext password for server startup
@rem STARTMODE      - Set to true for production mode servers, false for 
@rem                  development mode
@rem JAVA_OPTIONS   - Java command-line options for running the server. (These
@rem                  will be tagged on to the end of the JAVA_VM and MEM_ARGS)
@rem JAVA_VM        - The java arg specifying the VM to run.  (i.e. -server, 
@rem                  -hotspot, etc.)
@rem MEM_ARGS       - The variable to override the standard memory arguments
@rem                  passed to java
@rem
@rem For additional information, refer to the WebLogic Server Administration 
@rem Guide (http://e-docs.bea.com/wls/docs70/adminguide/startstop.html).
@rem *************************************************************************

echo off
SETLOCAL

@rem Set SERVER_NAME to the name of the server you wish to start up.
set SERVER_NAME=
set ADMIN_URL=

@rem Set WLS_USER equal to your system username and WLS_PW equal  
@rem to your system password for no username and password prompt 
@rem during server startup.  Both are required to bypass the startup
@rem prompt.
set WLS_USER=
set WLS_PW=

@rem Set JAVA_OPTIONS to the java flags you want to pass to the vm. i.e.: 
@rem set JAVA_OPTIONS=-Dweblogic.attribute=value -Djava.attribute=value
set JAVA_OPTIONS=-Dweblogic.security.SSL.trustedCAKeyStore=C:\bea\weblogic700\server\lib\cacerts

@rem Set JAVA_VM to the java virtual machine you want to run.  For instance:
@rem set JAVA_VM=-server
set JAVA_VM=

@rem Set MEM_ARGS to the memory args you want to pass to java.  For instance:
@rem set MEM_ARGS=-Xms32m -Xmx200m
set MEM_ARGS=

@rem Set SERVER_NAME and ADMIN_URL, they must by specified before starting
@rem a managed server, detailed information can be found at
@rem http://e-docs.bea.com/wls/docs70/adminguide/startstop.html.
if "%1" == ""  goto checkEnvVars
set SERVER_NAME="%1"
if "%2" == "" goto checkEnvVars
set ADMIN_URL="%2"
goto callWebLogic

:checkEnvVars
if "%SERVER_NAME%" == "" goto usage
if "%ADMIN_URL%" == ""  goto usage
set SERVER_NAME="%SERVER_NAME%"
set ADMIN_URL="%ADMIN_URL%"
goto callWebLogic

:usage
echo Need to set SERVER_NAME and ADMIN_URL environment variables or specify
echo them in command line:
echo Usage: startManagedWebLogic [SERVER_NAME] [ADMIN_URL]
echo for example:
echo startManagedWebLogic managedserver1 http://localhost:7001
goto finish

:callWebLogic

@rem Call Weblogic Server
call "C:\bea\weblogic700\server\bin\startWLS.cmd"

:finish
ENDLOCAL
