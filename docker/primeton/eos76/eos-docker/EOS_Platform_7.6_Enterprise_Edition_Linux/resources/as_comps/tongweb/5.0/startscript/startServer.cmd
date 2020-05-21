@echo off
set JAVA_HOME=${RP_JAVA_HOME}
echo %JAVA_HOME%
set DIRNAME=%~dp0
if "%OS%" == "Windows_NT" set DIRNAME=%~dp0%

if not "%JAVA_HOME%" == "" goto ADD_TOOLS

set JAVA=java

echo ERROR: JAVA_HOME was not setted.
goto SKIP_TOOLS

:ADD_TOOLS

set JAVA=%JAVA_HOME%\bin\java

if exist "%JAVA_HOME%\lib\tools.jar" goto SKIP_TOOLS
echo ERROR: JAVA_HOME directory is wrong.

:SKIP_TOOLS

set JAVAC_JAR="%JAVA_HOME%\lib\tools.jar"


set TWNS_HOME=${RP_TONGWEB_HOME}

:SKIP

set SHARED_PATCHES=
set LANUCH_PATCHES=

if not exist "%TWNS_HOME%\patches\patch_script.bat" goto SKIP_PATCH
call "%TWNS_HOME%\patches\patch_script.bat"
:SKIP_PATCH

set TW_OPTS=-Dtongweb.root="%TWNS_HOME%"
set TW_OPTS=%TW_OPTS% -Dtongweb.serverName=server
set TW_OPTS=%TW_OPTS% -Dtongweb.verbose=true
set TW_OPTS=%TW_OPTS% -Dtongweb.restart.interval=1
set TW_OPTS=%TW_OPTS% -Djava.rmi.server.RMIClassLoaderSpi=com.tongweb.server.TongWebRMIClassLoader
set TW_OPTS=%TW_OPTS% -Djava.security.policy="%TWNS_HOME%\config\server.policy"
set TW_OPTS=%TW_OPTS% -Dtongweb.environmentFactory=com.tongweb.config.serverbeans.AppserverConfigEnvironmentFactory
set TW_OPTS=%TW_OPTS% -Dtongweb.pluggable.repository=com.tongweb.advance.server.pluggable.EEPluggableFeatureImpl
set TW_OPTS=%TW_OPTS% -Dtongweb.configFile="%TWNS_HOME%\config"
set TW_OPTS=%TW_OPTS% -Dtongweb.identity=false
set TW_OPTS=%TW_OPTS% -Dtongweb.taglibs=twns-jstl.jar,jsf-impl.jar
set TW_OPTS=%TW_OPTS% -Dtongweb.taglisteners=jsf-impl.jar
set TW_OPTS=%TW_OPTS% -Dtongweb.classloader.sharedChainJars=%SHARED_PATCHES%"%TWNS_HOME%\lib\ant\lib\ant.jar"
set TW_OPTS=%TW_OPTS% -Dtongweb.classloader.optionalOverrideableChain=webservices-rt.jar,webservices-tools.jar
set TW_OPTS=%TW_OPTS% -Dtongweb.classloader.excludesList=admin-cli.jar,twns-anttask.jar,twns-el.jar
set TW_OPTS=%TW_OPTS% -Dtongweb.classloader.appserverChainJars=admin-cli.jar,j2ee-svc.jar
set TW_OPTS=%TW_OPTS% -Dcom.tongweb.server.logging.max_history_files=20
set TW_OPTS=%TW_OPTS% -Dcom.sun.corba.ee.transport.ORBAcceptorSocketType=Socket
set TW_OPTS=%TW_OPTS% -Dcom.sun.corba.ee.transport.ORBConnectionSocketType=Socket

set TW_OPTS=%TW_OPTS% -DEXTERNAL_CONFIG_DIR=${RP_APPS_CONFIG}

set JAVA_OPTS=-Xmx896m

set JAVA_OPTS=%JAVA_OPTS% -XX:+UnlockDiagnosticVMOptions
set JAVA_OPTS=%JAVA_OPTS% -XX:+LogVMOutput
set JAVA_OPTS=%JAVA_OPTS% -XX:NewRatio=2
set JAVA_OPTS=%JAVA_OPTS% -XX:MaxPermSize=256m
set JAVA_OPTS=%JAVA_OPTS% -XX:LogFile="%TWNS_HOME%\logs\jvm.log"
set JAVA_OPTS=%JAVA_OPTS% -server
set JAVA_OPTS=%JAVA_OPTS% -Dsun.rmi.dgc.client.gcInterval=3600000
set JAVA_OPTS=%JAVA_OPTS% -Dsun.rmi.dgc.server.gcInterval=3600000
set JAVA_OPTS=%JAVA_OPTS% -Djava.util.logging.manager=com.tongweb.server.logging.ServerLogManager
set JAVA_OPTS=%JAVA_OPTS% -Djava.library.path="%TWNS_HOME%\lib";"%JAVA_HOME%\bin";.;C:\WINDOWS\system32;C:\WINDOWS;"%TWNS_HOME%\bin"
set JAVA_OPTS=%JAVA_OPTS% -Djava.endorsed.dirs="%TWNS_HOME%\lib\endorsed"
set JAVA_OPTS=%JAVA_OPTS% -Djavax.management.builder.initial=com.tongweb.advance.admin.AppServerMBeanServerBuilder
set JAVA_OPTS=%JAVA_OPTS% -Djava.security.auth.login.config="%TWNS_HOME%\config\login.conf"
set JAVA_OPTS=%JAVA_OPTS% -Djmx.invoke.getters=true
set JAVA_OPTS=%JAVA_OPTS% -Djava.ext.dirs="%JAVA_HOME%\lib\ext";"%JAVA_HOME%\jre\lib\ext";"%TWNS_HOME%\lib\ext";"%TWNS_HOME%\javadb\lib";"%TWNS_HOME%\lib\jdbcdrivers"
set JAVA_OPTS=%JAVA_OPTS% -Djava.net.preferIPv4Stack=true -Dorg.apache.jasper.compiler.Parser.STRICT_QUOTE_ESCAPING=false

set TWNS_CLASSPATH=%JAVAC_JAR%
set TWNS_CLASSPATH=%TWNS_CLASSPATH%;%LANUCH_PATCHES%"%TWNS_HOME%\lib\launch.jar";"%TWNS_HOME%\lib\license.jar"

rem parse arguments



if "%1"=="-debug" (
	set JAVA_OPTS=%JAVA_OPTS% -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8787 -DEOS_DEBUG=true
)

set EXTERNAL_CONFIG_DIR=${RP_APPS_CONFIG}


"%JAVA%" %JAVA_OPTS% %TW_OPTS%  -DEXTERNAL_CONFIG_DIR="%EXTERNAL_CONFIG_DIR%"  -classpath %TWNS_CLASSPATH% com.tongweb.server.PELaunch start	

:END

set JAVA_OPTS=
if "%NOPAUSE%" == "" pause

:END_NO_PAUSE

:LIBAPPEND
set JARS=%JARS%;%1
