@rem *************************************************************************
@rem This script is used to uninstall a WebLogic Server service for the
@rem domain in the current working directory.  This script simply sets the 
@rem DOMAIN_NAME and SERVER_NAME variable and calls the uninstallSvc.cmd
@rem script under %WL_HOME%\server\bin.
@rem
@rem To create your own domain script, all you need to set is DOMAIN_NAME
@rem and SERVER_NAME, then call %WL_HOME%\server\bin\uninstallSvc.cmd
@rem
@rem For additional information, refer to the WebLogic Server Administration 
@rem Guide (http://e-docs.bea.com/wls/docs70/adminguide/startstop.html).
@rem *************************************************************************

echo off
SETLOCAL

@rem Set DOMAIN_NAME to the name of the server you wish to start up.
set DOMAIN_NAME=forum

@rem Set SERVER_NAME to the name of the server you wish to start up.
set SERVER_NAME=forum

@rem Call Weblogic Server service uninstallation script 
call "C:\bea\weblogic700\server\bin\uninstallSvc.cmd"

ENDLOCAL
