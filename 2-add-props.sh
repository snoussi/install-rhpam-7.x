#!/bin/sh
AUTHORS1="Rachid Snoussi"

echo "Start Server first by running this command: ./standalone.sh -c standalone-full.xml --admin-only"

TARGET=../
#TODO: Edit EAP version
JBOSS_HOME=$TARGET/rhpam-7.10
CLI_SCRIPT=2-add-props.cli

if [ ! -z "$CLI_SCRIPT" ]
then
	echo "Executing CLI script: " $CLI_SCRIPT
	$JBOSS_HOME/bin/jboss-cli.sh -c --file=$CLI_SCRIPT
fi