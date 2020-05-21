#!/bin/sh
# -----------------------------------------------------------------------------
# Stop script for the PAS Server
#
# $Id: stopServer.sh,v 1.0 2012/04/16 13:40:36 build Exp $
# -----------------------------------------------------------------------------

# resolve links - $0 may be a softlink
PRG="$0"
CURRENT_DIR="%{RP_PAS_HOME}/bin"
JAVA_HOME="%{RP_JAVA_HOME}"
export JAVA_HOME 

sh ${CURRENT_DIR}/shutdown.sh $*