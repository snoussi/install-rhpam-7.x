#!/bin/sh

AUTHORS1="Rachid Snoussi"

echo "Start Server first by running this command: ./standalone.sh -c standalone-full.xml --admin-only"

TARGET=../
#TODO: Edit EAP version
JBOSS_HOME=$TARGET/rhpam-7.5

./reset-db.sh

if [ ! -z "add_postgresql_module_eap7.cli" ]
then
  echo "Executing CLI script: " add_postgresql_module_eap7.cli
  $JBOSS_HOME/bin/jboss-cli.sh -c --file=add_postgresql_module_eap7.cli
fi

if [ ! -z "add_postgresqlDriver.cli" ]
then
  echo "Executing CLI script: " add_postgresqlDriver.cli
  $JBOSS_HOME/bin/jboss-cli.sh -c --file=add_postgresqlDriver.cli
fi

if [ ! -z "add_pamDataSource.cli" ]
then
  echo "Executing CLI script: " add_pamDataSource.cli
  $JBOSS_HOME/bin/jboss-cli.sh -c --file=add_pamDataSource.cli
fi

if [ ! -z "add_kieServerPersistanceProps.cli" ]
then
  echo "Executing CLI script: " add_kieServerPersistanceProps.cli
  $JBOSS_HOME/bin/jboss-cli.sh -c --file=add_kieServerPersistanceProps.cli
fi


echo "IMPORTANT: For PostgreSQL to be able to handle XA transaction, change the configuration parameter max_prepared_transactions to an value higher than 0."