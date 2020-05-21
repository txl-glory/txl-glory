@echo off
rem -------------------------------------------------------------------------
rem JBoss Bootstrap Script for Win32
rem -------------------------------------------------------------------------

rem $Id: startServer.cmd,v 1.5 2009/03/24 07:01:56 wangcq Exp $

@if not "%ECHO%" == ""  echo %ECHO%
@if "%OS%" == "Windows_NT"  setlocal


set JBOSS_HOME=${RP_JBOSS_HOME}
set DIRNAME=${RP_JBOSS_HOME}/bin

set PROGNAME=run.bat
if "%OS%" == "Windows_NT" set PROGNAME=%~nx0%

set JAVA_HOME=${RP_JAVA_HOME}
set EXTERNAL_CONFIG_DIR=${RP_APPS_CONFIG}

rem Read all command line arguments

REM
REM The %ARGS% env variable commented out in favor of using %* to include
REM all args in java command line. See bug #840239. [jpl]
REM
REM set ARGS=
REM :loop
REM if [%1] == [] goto endloop
REM        set ARGS=%ARGS% %1
REM        shift
REM        goto loop
REM :endloop

rem Find run.jar, or we can't continue

set RUNJAR=%DIRNAME%\run.jar
if exist "%RUNJAR%" goto FOUND_RUN_JAR
echo Could not locate %RUNJAR%. Please check that you are in the
echo bin directory when running this script.
goto END

:FOUND_RUN_JAR

if not "%JAVA_HOME%" == "" goto ADD_TOOLS

set JAVA=java

echo JAVA_HOME is not set.  Unexpected results may occur.
echo Set JAVA_HOME to the directory of your local JDK to avoid this message.
goto SKIP_TOOLS

:ADD_TOOLS

set JAVA=%JAVA_HOME%\bin\java

if exist "%JAVA_HOME%\lib\tools.jar" goto SKIP_TOOLS
echo Could not locate %JAVA_HOME%\lib\tools.jar. Unexpected results may occur.
echo Make sure that JAVA_HOME points to a JDK and not a JRE.

:SKIP_TOOLS

rem Include the JDK javac compiler for JSP pages. The default is for a Sun JDK
rem compatible distribution to which JAVA_HOME points

set JAVAC_JAR=%JAVA_HOME%\lib\tools.jar

rem If JBOSS_CPATH is empty, don't include it, as this will
rem result in including the local directory, which makes error tracking
rem harder.
set JBOSS_CLASSPATH=%JBOSS_CLASSPATH%;%JAVAC_JAR%;%RUNJAR%;

rem Setup JBoss specific properties
set JAVA_OPTS=%JAVA_OPTS% -Dprogram.name=%PROGNAME% -Xms128m -Xmx896m -XX:MaxPermSize=256m -XX:+HeapDumpOnOutOfMemoryError

rem set JBOSS_CLASSPATH=%JBOSS_CLASSPATH%;%JAVAC_JAR%;%RUNJAR%

rem Sun JVM memory allocation pool parameters. Uncomment and modify as appropriate.

rem JPDA options. Uncomment and modify as appropriate to enable remote debugging.
rem set JAVA_OPTS=-classic -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=8787,server=y,suspend=y %JAVA_OPTS%
if "%1"=="-debug" (
	set JAVA_OPTS=-Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8787 %JAVA_OPTS%
	shift
)

echo ===============================================================================
echo .
echo   JBoss Bootstrap Environment
echo .
echo   JBOSS_HOME: %JBOSS_HOME%
echo .
echo   JAVA: %JAVA%
echo .
echo   JAVA_OPTS: %JAVA_OPTS%
echo .
echo   CLASSPATH: %JBOSS_CLASSPATH%
echo .
echo ===============================================================================
echo .

:RESTART
"%JAVA%" %JAVA_OPTS% -classpath "%JBOSS_CLASSPATH%" -Djboss.home.url="file:///%JBOSS_HOME%" -Djboss.home.dir="%JBOSS_HOME%" -Djavax.xml.soap.SAAJMetaFactory=com.sun.xml.messaging.saaj.soap.SAAJMetaFactoryImpl -DEXTERNAL_CONFIG_DIR=%EXTERNAL_CONFIG_DIR%  -Djava.net.preferIPv4Stack=true -Dorg.jboss.net.protocol.file.decodeFilePaths=true -Djboss.server.name=default -classpath "%JBOSS_CLASSPATH%" org.jboss.Main -c default

IF ERRORLEVEL 10 GOTO RESTART

:END
rem if "%NOPAUSE%" == "" pause

:END_NO_PAUSE
