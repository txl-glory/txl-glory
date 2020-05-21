#!/bin/bash

export DIRNAME=`dirname $0`

export JAVA_HOME="%{RP_JAVA_HOME}"

export CATALINA_BASE="%{RP_TOMCAT_HOME}"
export EXTERNAL_CONFIG_DIR="%{RP_APPS_CONFIG}"

export JAVAC_JAR="${JAVA_HOME}/lib/tools.jar"
export RUNJAR="${CATALINA_BASE}/bin/bootstrap.jar"
export JAVA_OPTS="-Xms128m -Xmx896m -XX:MaxPermSize=256m %{RP_HeapDump} %{RP_GcPolicy}"
if [ "$1" = "-debug" ]
then
    export JAVA_OPTS="${JAVA_OPTS} -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8787 -DEOS_DEBUG=true"
fi
export JAVA_OPTS="${JAVA_OPTS} -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djava.util.logging.config.file="${CATALINA_BASE}/conf/logging.properties""
export CATALINA_CLASSPATH="${JAVAC_JAR}:${RUNJAR}:"

echo '***************************************************'
echo '*  To start Tomcat Server, use the password       *'
echo '*  assigned to the system user.  The system       *'
echo '*  username and password must also be used to     *'
echo '*  access the Tomcat Server console from a web    *'
echo '*  browser.                                       *'
echo '***************************************************'

${JAVA_HOME}/bin/java ${JAVA_OPTS} -DEXTERNAL_CONFIG_DIR=${EXTERNAL_CONFIG_DIR} \
-Djava.endorsed.dirs=${CATALINA_BASE}/common/endorsed -classpath ${CATALINA_CLASSPATH} \
-Dcatalina.base=${CATALINA_BASE} -Djava.net.preferIPv4Stack=true -Djava.awt.headless=true -Dcatalina.home=${CATALINA_BASE} -Djava.io.tmpdir=${CATALINA_BASE}/temp \
org.apache.catalina.startup.Bootstrap  start
