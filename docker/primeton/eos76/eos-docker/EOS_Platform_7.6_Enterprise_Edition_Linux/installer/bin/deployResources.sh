#!/bin/sh

if [ -z "${JAVA_HOME}" ] ; then
   echo the envionment variables of JAVA_HOME is null , please export it
else
    JAVA_HOME=${JAVA_HOME}
    export JAVA_HOME
fi

# add the libraries to the INSTALL_CLASSPATH.
# EXEDIR is the directory where this executable is.

EXEDIR=`dirname $0`
DIRLIBS=${EXEDIR}/../lib/*.jar
for i in ${DIRLIBS}
do
  if [ -z "${INSTALL_CLASSPATH}" ] ; then
    INSTALL_CLASSPATH=$i
  else
    INSTALL_CLASSPATH="$i":$INSTALL_CLASSPATH
  fi
done

DIRLIBS=${EXEDIR}/../lib/*.zip
for i in ${DIRLIBS}
do
  if [ -z "$INSTALL_CLASSPATH" ] ; then
    INSTALL_CLASSPATH=$i
  else
    INSTALL_CLASSPATH="$i":$INSTALL_CLASSPATH
  fi
done

#export JAVA_OPTS=$JAVA_OPTS -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8787

${JAVA_HOME}/bin/java $JAVA_OPTS -classpath "${INSTALL_CLASSPATH}:${CLASSPATH}" com.primeton.install.ext.tools.DeployResourcesUtils

