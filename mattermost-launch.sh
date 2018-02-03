#!/bin/bash -x

MM_USERNAME=${DB_USER:-mmuser}
MM_PASSWORD=${DB_PASSWORD:-mostest}
MM_DBNAME=${DB_DATABASE:-mattermost}


if [ ! -f /opt/mattermost/data/config.json ]; then
	echo -ne "Configure new config.json..."
	sed "s/MATTERMOST_DATASOURCE_REPLACE/postgres:\/\/$DB_USER:$DB_PASSWORD\@$POSTGRESQL_SERVICE_HOST:$POSTGRESQL_SERVICE_PORT\/$DB_DATABASE?sslmode=disable\&connect_timeout=10/" /opt/mattermost/config/config.json > /tmp/config.json
	cp /opt/mattermost/config/config.json /tmp/config.json.org
	cat /tmp/config.json >/opt/mattermost/data/config.json
	cat /tmp/config.json.org |grep -i data
echo "done"
else
	echo -ne "Using existing config: /opt/mattermost/data/config.json"
fi

exec /opt/mattermost/bin/platform -c /opt/mattermost/data/config.json
