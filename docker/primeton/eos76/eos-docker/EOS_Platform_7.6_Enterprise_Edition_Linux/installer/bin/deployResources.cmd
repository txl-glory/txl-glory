echo off

cls

if not exist "%JAVA_HOME%\bin\java.exe" (
	echo The JAVA_HOME environment variable is not defined correctly
	echo This environment variable is needed to run this program
	exit /b 1
)

set TMP_CLASSPATH=%CLASSPATH%

for %%i in (%0) do cd /d %%~dpi\..

rem Add all jars....

for %%i in (".\lib\*.jar") do call ".\bin\cpappend.cmd" %%i
for %%i in (".\lib\*.zip") do call ".\bin\cpappend.cmd" %%i

set INSTALL_CLASSPATH=%CLASSPATH%
set CLASSPATH=%TMP_CLASSPATH%

rem set JAVA_OPTS=%JAVA_OPTS% -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8787

"%JAVA_HOME%\bin\java.exe" %JAVA_OPTS% -cp "%INSTALL_CLASSPATH%" -Xms24m -Xmx512m com.primeton.install.ext.tools.DeployResourcesUtils %*


