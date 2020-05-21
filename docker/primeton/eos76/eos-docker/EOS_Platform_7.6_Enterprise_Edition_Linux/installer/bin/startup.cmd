@echo off
set TMP_CLASSPATH=%CLASSPATH%
set RUNMODE=swing

for %%i in (%0) do cd /d %%~dpi\..


rem Add all jars....

for %%i in (".\lib\*.jar") do call ".\bin\cpappend.cmd" %%i
for %%i in (".\lib\*.zip") do call ".\bin\cpappend.cmd" %%i

for %%i in ("..\resource\eos\lib\jdbc\*.jar") do call ".\bin\cpappend.cmd" %%i
for %%i in ("..\resource\eos\lib\jdbc\*.zip") do call ".\bin\cpappend.cmd" %%i

set INSTALL_CLASSPATH=%CLASSPATH%
set CLASSPATH=%TMP_CLASSPATH%
set LOGFILE_NAME=eos_platform_7.6_install.log
if "%1"=="-debug" (
	set JAVA_OPTS=%JAVA_OPTS% -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8787
)
set isNohup=true

if "%3" =="-silent" goto errorArg

if "%2" =="-nohup" goto errorArg

if "%1" =="-silent" (
	set RUNMODE=silent
	goto useJava
)

if "%1" =="-nohup" set isNohup=%2

if not "%isNohup%" =="true" goto useJava
"%JAVA_HOME%\bin\javaw" %JAVA_OPTS% -cp "%INSTALL_CLASSPATH%" -Xms24m -Xmx512m  -Dinstall.logfile="%LOGFILE_NAME%" com.primeton.install.ext.ProductInstaller %*
goto end

:errorArg
echo input parameter error.
echo Usage :
echo        "install [-silent|-nohup [true|false]]"
echo Sample:
echo        install.cmd  -silent
echo        install.cmd  -nohup true
echo        install.cmd  -nohup false
goto end

:useJava

"%JAVA_HOME%\bin\java" %JAVA_OPTS% -cp "%INSTALL_CLASSPATH%" -Xms24m -Xmx512m  -Dinstall.logfile="%LOGFILE_NAME%" -Dinstall.runmode=%RUNMODE% com.primeton.install.ext.ProductInstaller %*
:end
cd..
