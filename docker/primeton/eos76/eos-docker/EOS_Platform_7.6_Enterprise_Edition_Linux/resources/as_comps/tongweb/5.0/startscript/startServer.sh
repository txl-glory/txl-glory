#!/bin/sh

DIRNAME=`pwd` 
JAVA_HOME=%{RP_JAVA_HOME}
JAVA=${JAVA_HOME}/bin/java
if [ ! "${JAVA_HOME}/lib/tools.jar" ] ; then   
	echo ERROR: JAVA_HOME directory is wrong.  
        exit 1
fi
JAVAC_JAR=${JAVA_HOME}/lib/tools.jar
TWNS_HOME="%{RP_TONGWEB_HOME}"


SHARED_PATCHES=
LANUCH_PATCHES=

if [ -f "${TWNS_HOME}/patches/patch_script.sh" ] ; then   
	. ${TWNS_HOME}/patches/patch_script.sh
fi


TW_OPTS=" -Dtongweb.root=${TWNS_HOME}"
TW_OPTS="${TW_OPTS} -Djava.awt.headless=true"
TW_OPTS="${TW_OPTS} -Dtongweb.serverName=server"
TW_OPTS="${TW_OPTS} -Dtongweb.verbose=true"
TW_OPTS="${TW_OPTS} -Dtongweb.restart.interval=1"
TW_OPTS="${TW_OPTS} -Djava.rmi.server.RMIClassLoaderSpi=com.tongweb.server.TongWebRMIClassLoader"
TW_OPTS="${TW_OPTS} -Djava.security.policy=${TWNS_HOME}/config/server.policy"
TW_OPTS="${TW_OPTS} -Dtongweb.environmentFactory=com.tongweb.config.serverbeans.AppserverConfigEnvironmentFactory"
TW_OPTS="${TW_OPTS} -Dtongweb.pluggable.repository=com.tongweb.advance.server.pluggable.EEPluggableFeatureImpl"
TW_OPTS="${TW_OPTS} -Dtongweb.configFile=${TWNS_HOME}/config"
TW_OPTS="${TW_OPTS} -Dtongweb.identity=false"
TW_OPTS="${TW_OPTS} -Dtongweb.taglibs=twns-jstl.jar,jsf-impl.jar"
TW_OPTS="${TW_OPTS} -Dtongweb.taglisteners=jsf-impl.jar"
TW_OPTS="${TW_OPTS} -Dtongweb.classloader.sharedChainJars=${SHARED_PATCHES}${TWNS_HOME}/lib/ant/lib/ant.jar"
TW_OPTS="${TW_OPTS} -Dtongweb.classloader.optionalOverrideableChain=webservices-rt.jar,webservices-tools.jar"
TW_OPTS="${TW_OPTS} -Dtongweb.classloader.excludesList=admin-cli.jar,twns-anttask.jar,twns-el.jar"
TW_OPTS="${TW_OPTS} -Dtongweb.classloader.appserverChainJars=admin-cli.jar,j2ee-svc.jar"
TW_OPTS="${TW_OPTS} -Dcom.tongweb.server.logging.max_history_files=20"
TW_OPTS="${TW_OPTS} -Dcom.sun.corba.ee.transport.ORBAcceptorSocketType=Socket"
TW_OPTS="${TW_OPTS} -Dcom.sun.corba.ee.transport.ORBConnectionSocketType=Socket"
export JAVA_OPTS="${JAVA_OPTS} -Djava.net.preferIPv4Stack=true -Dorg.apache.jasper.compiler.Parser.STRICT_QUOTE_ESCAPING=false"


export TWNS_CLASSPATH="${JAVAC_JAR}"
export TWNS_CLASSPATH="${TWNS_CLASSPATH}:${LANUCH_PATCHES}:${TWNS_HOME}\lib\launch.jar":"${TWNS_HOME}\lib\license.jar"


JAVA_OPTS="-Xmx896m"
JAVA_OPTS="${JAVA_OPTS} -Dfile.encoding=UTF-8"
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

export EXTERNAL_CONFIG_DIR=%{RP_APPS_CONFIG}

if [ "$1" = "-debug" ]
then
    export JAVA_OPTS="${JAVA_OPTS} -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8787 -DEOS_DEBUG=true"
fi

TWNS_CLASSPATH="${JAVAC_JAR}"
TWNS_CLASSPATH="${TWNS_CLASSPATH}:${LANUCH_PATCHES}${TWNS_HOME}/lib/launch.jar:${TWNS_HOME}/lib/license.jar"


START_CLASS=com.tongweb.server.PELaunch



exec ${JAVA} -classpath ${TWNS_CLASSPATH}  -DEXTERNAL_CONFIG_DIR=${EXTERNAL_CONFIG_DIR} ${JAVA_OPTS} ${TW_OPTS} ${START_CLASS} start
