#!/bin/bash

DIRNAME=`dirname $0`
export DIRNAME

JAVA_HOME="%{RP_JAVA_HOME}"
export JAVA_HOME

PAS_HOME="%{RP_PAS_HOME}"
export PAS_HOME

EXTERNAL_CONFIG_DIR="%{RP_APPS_CONFIG}"


JAVA_OPTS="-Xms128m -Xmx896m -XX:MaxPermSize=256m %{RP_HeapDump} %{RP_GcPolicy}"

if [ "$1" = "-debug" ]
then
    JAVA_OPTS="${JAVA_OPTS} -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8787 -DEOS_DEBUG=true"
fi

JAVA_OPTS="-DEXTERNAL_CONFIG_DIR=${EXTERNAL_CONFIG_DIR} -Djava.net.preferIPv4Stack=true ${JAVA_OPTS}"
export JAVA_OPTS

echo '***************************************************'
echo '*  To start PAS Server, use the password          *'
echo '*  assigned to the system user.  The system       *'
echo '*  username and password must also be used to     *'
echo '*  access the PAS Server console from a web       *'
echo '*  browser.                                       *'
echo '***************************************************'

sh ${PAS_HOME}/bin/geronimo.sh run