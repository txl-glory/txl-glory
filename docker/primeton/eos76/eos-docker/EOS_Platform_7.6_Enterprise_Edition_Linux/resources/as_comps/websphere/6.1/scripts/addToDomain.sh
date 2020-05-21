#!/bin/bash
usage()
{
	echo "To start server in managed server mode, you need to set MANAGED_SERVER_NAME ,ADMIN_IP and ADMIN_PORT environment variables or specify them in command line"
	echo "Usage: addDomain.sh MANAGED_SERVER_NAME ADMIN_IP ADMIN_PORT"
	echo "for example:"
	echo "addDomain.sh managedserver1 localhost 6500"
}

if [ "$1" = "" ] ; then
	if [ "${MANAGED_SERVER_NAME}" = "" ] ; then
		usage %0
		exit
	fi
else
	MANAGED_SERVER_NAME="$1"
	shift
fi

if [ "$1" = "" ] ; then
	if [ "${ADMIN_IP}" = "" ] ; then
		usage %0
		exit
	fi
else
	ADMIN_IP="$1"
	shift
fi

if [ "$1" = "" ] ; then
	if [ "${ADMIN_PORT}" = "" ] ; then
		usage %0
		exit
	fi
else
	ADMIN_PORT="$1"
	shift
fi


export JAVA_HOME="%{RP_JAVA_HOME}"

export ADDDOMAIN_BASE="%{RP_LIB_BASE}"

export EOS_HOME="%{RP_EOS_HOME}"

export EOS_JAR="${ADDDOMAIN_BASE}/eos-system.jar:${ADDDOMAIN_BASE}/eosinstall.jar:${ADDDOMAIN_BASE}/erector.jar:${ADDDOMAIN_BASE}/xstream-1.2.2.jar:${ADDDOMAIN_BASE}/commons-io-1.3.2.jar:${ADDDOMAIN_BASE}/log4j-1.2.8.jar:${ADDDOMAIN_BASE}/ant.jar"

export JAVA_OPTS="-Xms128m -Xmx896m"
export JAVA_OPTS=${JAVA_OPTS}

export EOSINSTALL_CLASSPATH="${EOS_JAR}"

    echo '****************************************************************'
	echo '* To start server in managed server mode,                      *'
	echo '* you need to set MANAGED_SERVER_NAME ,ADMIN_IP and ADMIN_PORT *'
	echo '* environment variables or specify them in command line:       *'
	echo '* Usage: addDomain.cmd MANAGED_SERVER_NAME ADMIN_IP ADMIN_PORT *'
	echo '* for example:                                                 *'
	echo '* addDomain.cmd managedserver1 localhost 6500                  *'
	echo '****************************************************************'

${JAVA_HOME}/bin/java ${JAVA_OPTS} -DEOS_HOME=${EOS_HOME} -classpath ${EOSINSTALL_CLASSPATH} com.primeton.eos.install.action.common.AddDomain ${MANAGED_SERVER_NAME} ${ADMIN_IP} ${ADMIN_PORT}
