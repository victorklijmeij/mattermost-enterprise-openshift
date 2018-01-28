#!/bin/bash -x

DB_HOST=${DB_HOST:-postgresql}
DB_PORT_5432_TCP_PORT=${DB_PORT_5432_TCP_PORT:-5432}
MM_USERNAME=${DB_USER:-mmuser}
MM_PASSWORD=${DB_PASSWORD:-mostest}
MM_DBNAME=${DB_DATABASE:-mattermost}

echo -ne "Configure PostgresSQL database connection..."

sed "s/MATTERMOST_DATASOURCE_REPLACE/$DB_USER:$DB_PASSWORD\@$DB_HOST:$DB_PORT_5432_TCP_PORT\/$DB_DATABASE?sslmode=disable\&connect_timeout=10connect_timeout=10/" /opt/mattermost/config/config.json > /tmp/config.json

cp /opt/mattermost/config/config.json /opt/mattermost/config/config.json.org
cat /tmp/config.json >/opt/mattermost/config/config.json

cat /opt/mattermost/config/config.json.org |grep -i Data
echo "done"

exec /opt/mattermost/bin/platform
