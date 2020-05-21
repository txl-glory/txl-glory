@echo off
if "%OS%" == "Windows_NT" setlocal
rem ---------------------------------------------------------------------------
rem Stop script for the PAS Server
rem
rem $Id: stopServer.cmd,v 1.0 2012/04/16 13:40:36 build Exp $
rem ---------------------------------------------------------------------------


set CURRENT_DIR="${RP_PAS_HOME}\bin"
set JAVA_HOME=${RP_JAVA_HOME}

call %CURRENT_DIR%\shutdown.bat %*