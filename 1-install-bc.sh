#!/bin/sh

PRODUCT="Red Hat Process Automation Manager 7.11.0 Business Central on EAP 7.3"

RHPAM_BC=rhpam-7.11.1-business-central-eap7-deployable

EAP=jboss-eap-7.3.0
EAP_PATCH=jboss-eap-7.3.5-patch

EAP_USER=admin
EAP_PWD=jboss1!

RHPAM_USER=pamAdmin
RHPAM_PWD=pamAdmin

TARGET=../
SRC_DIR=./installs

JBOSS_HOME=$TARGET/jboss-eap-7.3
RHPAM_HOME=$TARGET/rhpam-bc-7.11

echo
echo "#################################################################"
echo "##                                                             ##"
echo "   Installing ${PRODUCT}"
echo "##                                                             ##"
echo "##                                                             ##"
echo "#################################################################"
echo


# make some checks first before proceeding.
if [ -r $SRC_DIR/$EAP.zip ] || [ -L $SRC_DIR/$EAP.zip ]; then
  echo "Red Hat Product sources $EAP are present..."
  echo
else
  echo "Need to download $EAP.zip package from the Customer Portal"
  echo "and place it in the $SRC_DIR directory to proceed..."
  echo
  exit
fi

if [ -r $SRC_DIR/$EAP_PATCH.zip ] || [ -L $SRC_DIR/$EAP_PATCH.zip ]; then
  echo "Red Hat Product patches $EAP_PATCH.zip are present..."
  echo
else
  echo "Need to download $EAP_PATCH.zip package from the Customer Portal"
  echo "and place it in the $SRC_DIR directory to proceed..."
  echo
  exit
fi


if [ -r $SRC_DIR/$RHPAM_BC.zip ] || [ -L $SRC_DIR/$RHPAM_BC.zip ]; then
  echo "Red Hat Product sources $RHPAM_BC.zip are present..."
  echo
else
  echo "Need to download $RHPAM_BC.zip package from the Customer Portal"
  echo "and place it in the $SRC_DIR directory to proceed..."
  exit
fi


# Remove the old Red Hat instance, if it exists.
if [ -x $JBOSS_HOME ]; then
  echo "  - existing Red Hat product install detected in $JBOSS_HOME !"
  echo "  - existing Red Hat product install removed..."
  echo
  rm -rf $JBOSS_HOME
fi
if [ -x $RHPAM_HOME ]; then
  echo "  - existing Red Hat product install detected in $RHPAM_HOME !"
  echo "  - existing Red Hat product install removed..."
  echo
  rm -rf $RHPAM_HOME
fi
if [ -x ./patch_tmp ]; then
  echo "  - existing Red Hat product patch_tmp detected and removed..."
  echo
  rm -rf ./patch_tmp
fi


# Install EAP
echo
echo "EAP installer running now..."
echo
unzip -qo $SRC_DIR/$EAP.zip -d $TARGET
if [ $? -ne 0 ]; then
  echo
  echo "Error occurred during EAP installation!"
  exit
fi

# Add a default admin user.
echo
echo "Adding a default admin user on EAP ..."
echo
$JBOSS_HOME/bin/add-user.sh $EAP_USER $EAP_PWD --silent
if [ $? -ne 0 ]; then
  echo
  echo "Error occurred during EAP installation!"
  exit
fi

echo
echo "Applying $EAP_PATCH.zip patch now..."
echo
$JBOSS_HOME/bin/jboss-cli.sh --command="patch apply $SRC_DIR/$EAP_PATCH.zip --override-all"

if [ $? -ne 0 ]; then
 echo
 echo "Error occurred during EAP patching!"
 exit
fi

echo
echo "Deploying $PRODUCT ($RHPAM_BC) now..."
echo

unzip -qo $SRC_DIR/$RHPAM_BC.zip -d $TARGET

if [ $? -ne 0 ]; then
  echo
  echo "Error occurred during $PRODUCT installation!"
  exit
fi

# Create initial users
echo
echo "Creating initial users ..."
echo
$JBOSS_HOME/bin/add-user.sh -a -u $RHPAM_USER -p $RHPAM_PWD -ro admin,Administrators,kie-server,rest-all --silent
$JBOSS_HOME/bin/add-user.sh -a -u manager1 -p manager1 -ro manager,kie-server,rest-all --silent
$JBOSS_HOME/bin/add-user.sh -a -u user1 -p user1 -ro user,kie-server,rest-all --silent
$JBOSS_HOME/bin/add-user.sh -a -u user2 -p user2 -ro user,kie-server,rest-all --silent
$JBOSS_HOME/bin/add-user.sh -a -u pamController -p pamController -ro kie-server,rest-all --silent

if [ $? -ne 0 ]; then
  echo
  echo "Error occurred during EAP installation!"
  exit
fi

echo
echo "Renaming folders ..."
echo
mv $JBOSS_HOME $RHPAM_HOME

echo "Now, start server in administration mode by running this command: ./standalone.sh -c standalone-full.xml --admin-only"