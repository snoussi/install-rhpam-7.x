#!/bin/sh
AUTHORS1="Rachid Snoussi"

echo "Start Server first by running this command: ./standalone.sh -c standalone-full.xml --admin-only"

echo "Enter smtp server host name, eg. smtp.gmail.com"
read HOST

echo "Enter smtp server port number, eg. 465"
read PORT

echo "Enter username, eg. username@gmail.com"
read USERNAME

echo "Enter password"
read -s PASSWORD

TARGET=../
JBOSS_HOME=$TARGET/rhpam-7.7

$JBOSS_HOME/bin/jboss-cli.sh -c <<EOF
/socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=pam-mail-smtp/:add(host=$HOST, port=$PORT)
/subsystem=mail/mail-session=pam/:add(jndi-name=java:/pamMailSession, from=$USERNAME)
/subsystem=mail/mail-session=pam/server=smtp/:add(outbound-socket-binding-ref=pam-mail-smtp, ssl=true, username=$USERNAME, password=$PASSWORD)
/system-property=org.kie.mail.session:add(value="java:/pamMailSession")
# /socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=pam-mail-smtp/:remove
# /subsystem=mail/mail-session=pam/:remove
EOF