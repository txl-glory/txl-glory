#!/bin/sh

# WARNING: This file is created by the Configuration Wizard.
# Any changes to this script may be lost when adding extensions to this configuration.


EXTERNAL_CONFIG_DIR=%{RP_APPS_CONFIG}
export EXTERNAL_CONFIG_DIR

DOMAIN_HOME=%{RP_DOMAIN_HOME}
export DOMAIN_HOME

JAVA_OPTIONS="${JAVA_OPTIONS} -DJCEProvider=%{RP_JCEProvider}"

JAVA_OPTIONS="${JAVA_OPTIONS} -Djava.net.preferIPv4Stack=true"

JAVA_OPTIONS="${JAVA_OPTIONS} -Djava.awt.headless=true"

JAVA_OPTIONS="${JAVA_OPTIONS} -DEXTERNAL_CONFIG_DIR=${EXTERNAL_CONFIG_DIR}"

export JAVA_OPTIONS

CLASSPATH="${DOMAIN_HOME}/lib/mssqlserver-3.0.jar"

export CLASSPATH

USER_MEM_ARGS="-Xms128m -Xmx896m -XX:MaxPermSize=256M"
export USER_MEM_ARGS

( cd ${DOMAIN_HOME} ; ./bin/startWebLogic.sh $* )

