@ECHO OFF

@REM WARNING: This file is created by the Configuration Wizard.
@REM Any changes to this script may be lost when adding extensions to this configuration.

SETLOCAL

set EXTERNAL_CONFIG_DIR=${RP_APPS_CONFIG}
set DOMAIN_HOME=${RP_DOMAIN_HOME}
set MAN_PAN=true
set CLASSPATH=%DOMAIN_HOME%/lib/mssqlserver-3.0.jar

set JAVA_OPTIONS=%JAVA_OPTIONS% -DEXTERNAL_CONFIG_DIR="%EXTERNAL_CONFIG_DIR%"
call "%DOMAIN_HOME%/bin/startWebLogic.cmd" %*



ENDLOCAL