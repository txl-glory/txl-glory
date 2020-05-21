#!/bin/sh
DIRNAME=`pwd` 
JAVA_HOME=%{RP_JAVA_HOME}
JAVA=${JAVA_HOME}/bin/java
if [ !  "${JAVA_HOME}/lib/tools.jar" ] ; then   
	echo ERROR: JAVA_HOME directory is wrong.  
        exit 1
fi
JAVAC_JAR=${JAVA_HOME}/lib/tools.jar
TWNS_HOME="%{RP_TONGWEB_HOME}"


TW_OPTS=" -Dtongweb.root=${TWNS_HOME}"
TW_OPTS="${TW_OPTS} -Dtongweb.serverName=server"
TW_OPTS="${TW_OPTS} -Dtongweb.verbose=true"
TW_OPTS="${TW_OPTS} -Djava.rmi.server.RMIClassLoaderSpi=com.tongweb.server.TongWebRMIClassLoader"
TW_OPTS="${TW_OPTS} -Djavax.net.ssl.keyStore=${TWNS_HOME}/config/server.keystore"
TW_OPTS="${TW_OPTS} -Djavax.net.ssl.trustStore=${TWNS_HOME}/config/cacerts"
TW_OPTS="${TW_OPTS} -Djava.security.policy=${TWNS_HOME}/config/server.policy"
TW_OPTS="${TW_OPTS} -Dtongweb.environmentFactory=com.tongweb.config.serverbeans.AppserverConfigEnvironmentFactory"
TW_OPTS="${TW_OPTS} -Dtongweb.pluggable.repository=com.tongweb.advance.server.pluggable.EEPluggableFeatureImpl"
TW_OPTS="${TW_OPTS} -Dtongweb.logFile=${TWNS_HOME}/logs/server.log"
TW_OPTS="${TW_OPTS} -Dtongweb.configFile=${TWNS_HOME}/config"
TW_OPTS="${TW_OPTS} -Dtongweb.identity=false"
TW_OPTS="${TW_OPTS} -Dtongweb.taglibs=twns-jstl.jar,jsf-impl.jar"
TW_OPTS="${TW_OPTS} -Dtongweb.taglisteners=jsf-impl.jar"
TW_OPTS="${TW_OPTS} -Dtongweb.classloader.sharedChainJars=${TWNS_HOME}/lib/ant/lib/ant.jar"
TW_OPTS="${TW_OPTS} -Dtongweb.classloader.optionalOverrideableChain=webservices-rt.jar,webservices-tools.jar"
TW_OPTS="${TW_OPTS} -Dtongweb.classloader.excludesList=admin-cli.jar,twns-anttask.jar"
TW_OPTS="${TW_OPTS} -Dtongweb.classloader.appserverChainJars=admin-cli.jar,j2ee-svc.jar"

JAVA_OPTS="-Xmx512m"
JAVA_OPTS="${JAVA_OPTS} -XX:+UnlockDiagnosticVMOptions -XX:MaxPermSize=256m -XX:NewRatio=2 -XX:+LogVMOutput -XX:LogFile=${TWNS_HOME}/logs/jvm.log"
JAVA_OPTS="${JAVA_OPTS} -server"
JAVA_OPTS="${JAVA_OPTS} -Dsun.rmi.dgc.client.gcInterval=3600000"
JAVA_OPTS="${JAVA_OPTS} -Dsun.rmi.dgc.server.gcInterval=3600000"
JAVA_OPTS="${JAVA_OPTS} -Djava.util.logging.manager=com.tongweb.server.logging.ServerLogManager"
JAVA_OPTS="${JAVA_OPTS} -Djava.library.path=${TWNS_HOME}/lib:${JAVA_HOME}/bin:${TWNS_HOME}/bin"
JAVA_OPTS="${JAVA_OPTS} -Djava.endorsed.dirs=${TWNS_HOME}/lib/endorsed"
JAVA_OPTS="${JAVA_OPTS} -Djavax.management.builder.initial=com.tongweb.advance.admin.AppServerMBeanServerBuilder"
JAVA_OPTS="${JAVA_OPTS} -Djava.security.auth.login.config=${TWNS_HOME}/config/login.conf"
JAVA_OPTS="${JAVA_OPTS} -Djmx.invoke.getters=true"
JAVA_OPTS="${JAVA_OPTS} -Djava.ext.dirs=${JAVA_HOME}/lib/ext:${JAVA_HOME}/jre/lib/ext:${TWNS_HOME}/lib/ext:${TWNS_HOME}/javadb/lib"


TWNS_CLASSPATH="${JAVAC_JAR}"
TWNS_CLASSPATH="${TWNS_CLASSPATH}:${TWNS_HOME}/lib/launch.jar:${TWNS_HOME}/lib/license.jar"

START_CLASS=com.tongweb.server.PELaunch

exec ${JAVA} -classpath ${TWNS_CLASSPATH} ${JAVA_OPTS} ${TW_OPTS} ${START_CLASS} stop
                                                                                             
