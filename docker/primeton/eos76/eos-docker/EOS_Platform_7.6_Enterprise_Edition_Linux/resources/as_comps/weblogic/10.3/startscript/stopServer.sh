#!/bin/sh

# WARNING: This file is created by the Configuration Wizard.
# Any changes to this script may be lost when adding extensions to this configuration.


DOMAIN_HOME=%{RP_DOMAIN_HOME}
export DOMAIN_HOME

EXTERNAL_CONFIG_DIR=%{RP_APPS_CONFIG}
export EXTERNAL_CONFIG_DIR

JAVA_OPTIONS="${JAVA_OPTIONS} -DEXTERNAL_CONFIG_DIR=${EXTERNAL_CONFIG_DIR}"
export JAVA_OPTIONS

${DOMAIN_HOME}/bin/stopWebLogic.sh $*
