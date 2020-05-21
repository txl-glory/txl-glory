@echo off
if "%1"=="" (
	if "%MANAGED_SERVER_NAME%"=="" (
		rem CALL :usage %0
		GOTO :usage
	)
) else (
	set MANAGED_SERVER_NAME=%1
	shift
)

if "%1"=="" (
	if "%ADMIN_IP%"=="" (
		rem CALL :usage %0
		GOTO :usage
	)
) else (
	set ADMIN_IP=%1
	shift
)

if "%1"=="" (
	if "%ADMIN_PORT%"=="" (
		rem CALL :usage %0
		GOTO :usage
	)
) else (
	set ADMIN_PORT=%1
	shift
)
SETLOCAL
@rem Set user-defined variables.

set JAVA_HOME=${RP_JAVA_HOME}
set ADDDOMAIN_BASE=${RP_LIB_BASE}
set EOS_HOME=${RP_EOS_HOME} 

set EOS_JAR=%ADDDOMAIN_BASE%/eos-system.jar;%ADDDOMAIN_BASE%/eosinstall.jar;%ADDDOMAIN_BASE%/erector.jar;%ADDDOMAIN_BASE%/xstream-1.2.2.jar;%ADDDOMAIN_BASE%/commons-io-1.3.2.jar;%ADDDOMAIN_BASE%/log4j-1.2.8.jar;%ADDDOMAIN_BASE%/ant.jar

set JAVA_OPTS=-Xms128m -Xmx896m
set JAVA_OPTS=%JAVA_OPTS%

set EOSINSTALL_CLASSPATH=%EOS_JAR%


@echo off
"%JAVA_HOME%\bin\java" %JAVA_OPTS% -DEOS_HOME="%EOS_HOME%" -classpath "%EOSINSTALL_CLASSPATH%" com.primeton.eos.install.action.common.AddDomain %MANAGED_SERVER_NAME% %ADMIN_IP% %ADMIN_PORT%
GOTO :EOF
:usage
    echo.
    echo ****************************************************************
	echo * To start server in managed server mode,                      *
	echo * you need to set MANAGED_SERVER_NAME ,ADMIN_IP and ADMIN_PORT   *
	echo * environment variables or specify them in command line:       *
	echo * Usage: addToDomain.cmd MANAGED_SERVER_NAME ADMIN_IP ADMIN_PORT   *
	echo * for example:                                                 *
	echo * addDomain.cmd managedserver1 localhost 6500                  *
	echo ****************************************************************
GOTO :EOF
