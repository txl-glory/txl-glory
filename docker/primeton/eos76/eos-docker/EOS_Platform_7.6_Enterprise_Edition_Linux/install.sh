#!/bin/sh

if [ "$1" = "-help" ]
then
    echo "For a silent installation, please specify option \"-silent\" "
    echo "For a GUI installation, please specify nothing"
    exit 1
elif [ "$1" -a "$1" != "-silent" ]
then
    echo "Unknown Option Name!"
    echo "."
    echo "For a silent installation, please specify option \"-silent\" "
    echo "For a GUI installation, please specify nothing"
    echo "."
    echo "Installation Cancelled!"
    exit 1
fi

DIRNAME=`dirname $0`
JAVA_HOME=`cd ${DIRNAME};pwd`/jre
export JAVA_HOME

BASEPATH=`cd ${DIRNAME};pwd`
STARTUP="$BASEPATH"/installer/bin/startup.sh
JRE_BIN="$BASEPATH"/jre/bin
JRE_BIN_BIN="$BASEPATH"/jre/jre/bin
chmod -R a+x "$JAVA_HOME"
chmod -R a+x "$STARTUP"

cd ${DIRNAME}/installer/bin

./startup.sh $1


