#!/bin/sh
# add the libraries to the INSTALL_CLASSPATH.
# EXEDIR is the directory where this executable is.

EXEDIR=`dirname $0`
DIRLIBS=${EXEDIR}/../lib/*.jar
for i in ${DIRLIBS}
do
  if [ -z "$INSTALL_CLASSPATH" ] ; then
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

LOGFILE_NAME=eos_platform_7.6_install.log
export LOGFILE_NAME

RUNMODE=swing
export RUNMODE

if [ "${1}" = "-silent" ] ; then
	RUNMODE="silent"
	export RUNMODE
fi


#JAVA_OPTS="$JAVA_OPTS -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8787"

"${JAVA_HOME}/bin/java" $JAVA_OPTS -Dinstall.runmode="$RUNMODE" -Dinstall.logfile="$LOGFILE_NAME" -classpath "$INSTALL_CLASSPATH:$CLASSPATH" com.primeton.install.ext.ProductInstaller


