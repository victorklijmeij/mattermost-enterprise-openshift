#!/bin/bash -x

MM_USERNAME=${DB_USER:-mmuser}
MM_PASSWORD=${DB_PASSWORD:-mostest}
MM_DBNAME=${DB_DATABASE:-mattermost}

echo -ne "Configure PostgresSQL database connection..."

sed "s/MATTERMOST_DATASOURCE_REPLACE/postgres:\/\/$DB_USER:$DB_PASSWORD\@$POSTGRESQL_SERVICE_HOST:$POSTGRESQL_SERVICE_PORT\/$DB_DATABASE?sslmode=disable\&connect_timeout=10/" /opt/mattermost/config/config.json > /tmp/config.json

cp /opt/mattermost/config/config.json /tmp/config.json.org
cat /tmp/config.json >/opt/mattermost/config/config.json
cat /tmp/config.json.org |grep -i data
echo "done"

exec /opt/mattermost/bin/platform
