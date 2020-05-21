cls
@echo on

SETLOCAL
@rem Set user-defined variables.

set DIRNAME=%~dp0
set JAVA_HOME=${RP_JAVA_HOME}
set PAS_HOME=${RP_PAS_HOME}
set EXTERNAL_CONFIG_DIR=${RP_APPS_CONFIG}

set JAVA_OPTS=-Xms128m -Xmx896m -XX:MaxPermSize=256m ${RP_HeapDump} ${RP_GcPolicy}

if "%1"=="-debug" (
	set JAVA_OPTS=%JAVA_OPTS% -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8787 -DEOS_DEBUG=true
	)
set JAVA_OPTS=-DEXTERNAL_CONFIG_DIR=%EXTERNAL_CONFIG_DIR% -Djava.net.preferIPv4Stack=true %JAVA_OPTS%
echo.
echo ***************************************************
echo *  To start PAS Server, use the password          *
echo *  assigned to the system user.  The system       *
echo *  username and password must also be used to     *
echo *  access the PAS Server console from a web       *
echo *  browser.                                       *
echo ***************************************************

@echo on
call %PAS_HOME%\bin\geronimo.bat run
