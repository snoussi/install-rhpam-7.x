#!/bin/sh
AUTHORS1="Rachid Snoussi"

echo "Start Server first by running this command: ./standalone.sh -c standalone-full.xml --admin-only"

TARGET=../
JBOSS_HOME=$TARGET/rhpam-7.11
CLI_SCRIPT=3-add-kieserver-props.cli

echo "Adding a pamController user on JBoss EAP ..."
echo
$JBOSS_HOME/bin/add-user.sh -a -u pamController -p pamController -ro kie-server,rest-all --silent
if [ $? -ne 0 ]; then
  echo
  echo Error occurred during user adding !
  exit
fi

if [ ! -z "$CLI_SCRIPT" ]
then
	echo "Executing CLI script: " $CLI_SCRIPT
	$JBOSS_HOME/bin/jboss-cli.sh -c --file=$CLI_SCRIPT
fi