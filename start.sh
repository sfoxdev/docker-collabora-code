#!/bin/bash

if [ -z "$DOMAIN" ]; then
  hostname=localhost
else
  hostname=$DOMAIN
fi

DOMAIN_NAME=$(echo "$DOMAIN" | sed 's/\./\\\\./g')

# Fix lool resolv.conf problem (wizdude)
rm /opt/lool/systemplate/etc/resolv.conf
ln -s /etc/resolv.conf /opt/lool/systemplate/etc/resolv.conf

cp /srv/ssl/* /etc/loolwsd/
chmod 644 /etc/loolwsd/*

# Replace trusted host and set admin username and password
perl -pi -e "s/localhost<\/host>/${DOMAIN_NAME}<\/host>/g" /etc/loolwsd/loolwsd.xml
perl -pi -e "s/<username desc=\"The username of the admin console. Must be set.\"><\/username>/<username desc=\"The username of the admin console. Must be set.\">${USERNAME}<\/username>/" /etc/loolwsd/loolwsd.xml
perl -pi -e "s/<password desc=\"The password of the admin console. Must be set.\"><\/password>/<password desc=\"The password of the admin console. Must be set.\">${PASSWORD}<\/password>/g" /etc/loolwsd/loolwsd.xml

# Start loolwsd
su -c "/usr/bin/loolwsd --version --o:sys_template_path=/opt/lool/systemplate --o:lo_template_path=/opt/collaboraoffice5.3 --o:child_root_path=/opt/lool/child-roots --o:file_server_root_path=/usr/share/loolwsd" -s /bin/bash lool
