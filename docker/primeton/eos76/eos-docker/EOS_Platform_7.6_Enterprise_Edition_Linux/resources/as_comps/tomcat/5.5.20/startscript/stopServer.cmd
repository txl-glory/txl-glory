@echo off
if "%OS%" == "Windows_NT" setlocal
rem ---------------------------------------------------------------------------
rem Stop script for the CATALINA Server
rem
rem $Id: stopServer.cmd,v 1.1 2008/07/04 13:40:36 build Exp $
rem ---------------------------------------------------------------------------

rem Guess CATALINA_HOME if not defined
set CURRENT_DIR="${RP_TOMCAT_HOME}\bin"
set JAVA_HOME=${RP_JAVA_HOME}
if not "%CATALINA_HOME%" == "" goto gotHome
set CATALINA_HOME=%CURRENT_DIR%

if exist "%CATALINA_HOME%\bin\catalina.bat" goto okHome

set CATALINA_HOME="${RP_TOMCAT_HOME}"
cd %CURRENT_DIR%
:gotHome
if exist "%CATALINA_HOME%\bin\catalina.bat" goto okHome
echo The CATALINA_HOME environment variable is not defined correctly
echo This environment variable is needed to run this program
goto end
:okHome

set EXECUTABLE=%CATALINA_HOME%\bin\catalina.bat

rem Check that target executable exists
if exist "%EXECUTABLE%" goto okExec
echo Cannot find %EXECUTABLE%
echo This file is needed to run this program
goto end
:okExec

rem Get remaining unshifted command line arguments and save them in the
set CMD_LINE_ARGS=
:setArgs
if ""%1""=="""" goto doneSetArgs
set CMD_LINE_ARGS=%CMD_LINE_ARGS% %1
shift
goto setArgs
:doneSetArgs
echo %EXECUTABLE% , %CMD_LINE_ARGS%
call "%EXECUTABLE%" stop %CMD_LINE_ARGS%

:end