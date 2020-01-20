#!/bin/sh
AUTHORS1="Rachid Snoussi"

echo "Start Server first by running this command: ./standalone.sh -c standalone-full.xml --admin-only"

TARGET=../
#TODO: Edit EAP version
JBOSS_HOME=$TARGET/rhpam-7.6
CLI_SCRIPT=add-props.cli

# mkdir $JBOSS_HOME/pam-data

if [ ! -z "$CLI_SCRIPT" ]
then
	echo "Executing CLI script: " $CLI_SCRIPT
	$JBOSS_HOME/bin/jboss-cli.sh -c --file=$CLI_SCRIPT
fi