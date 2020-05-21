cls
@echo on

SETLOCAL
@rem Set user-defined variables.

set DIRNAME=%~dp0
set JAVA_HOME=${RP_JAVA_HOME}
set CATALINA_BASE=${RP_TOMCAT_HOME}
set EXTERNAL_CONFIG_DIR=${RP_APPS_CONFIG}

set JAVAC_JAR=%JAVA_HOME%\lib\tools.jar
set RUNJAR=%CATALINA_BASE%\bin\bootstrap.jar;%CATALINA_BASE%\bin\tomcat-juli.jar
set JAVA_OPTS=-Xms128m -Xmx896m -XX:MaxPermSize=256m ${RP_HeapDump} ${RP_GcPolicy}
set JAVA_OPTS=%JAVA_OPTS% -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djava.util.logging.config.file="%CATALINA_BASE%\conf\logging.properties"

set CATALINA_CLASSPATH=%JAVAC_JAR%;%RUNJAR%;
if "%1"=="-debug" (
	set JAVA_OPTS=%JAVA_OPTS% -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8787 -DEOS_DEBUG=true
	)
echo.
echo ***************************************************
echo *  To start Tomcat Server, use the password       *
echo *  assigned to the system user.  The system       *
echo *  username and password must also be used to     *
echo *  access the Tomcat Server console from a web    *
echo *  browser.                                       *
echo ***************************************************

@echo on
"%JAVA_HOME%\bin\java" %JAVA_OPTS% -DEXTERNAL_CONFIG_DIR="%EXTERNAL_CONFIG_DIR%" -Djava.net.preferIPv4Stack=true -Dorg.apache.jasper.compiler.Parser.STRICT_QUOTE_ESCAPING=false -Djava.endorsed.dirs="%CATALINA_BASE%\common\endorsed" -classpath "%CATALINA_CLASSPATH%" -Dcatalina.base="%CATALINA_BASE%" -Dcatalina.home="%CATALINA_BASE%" -Djava.io.tmpdir="%CATALINA_BASE%\temp" org.apache.catalina.startup.Bootstrap  start
