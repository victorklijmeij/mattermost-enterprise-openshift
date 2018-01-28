#!/bin/bash -x

DB_HOST=${DB_HOST:-mysql}
DB_PORT_3306_TCP_PORT=${DB_PORT_3306_TCP_PORT:-3306}
MM_USERNAME=${DB_USER:-mmuser}
MM_PASSWORD=${DB_PASSWORD:-mostest}
MM_DBNAME=${DB_DATABASE:-mattermost_test}

echo -ne "Configure MySQL database connection..."

sed "s/MATTERMOST_DATASOURCE_REPLACE/$DB_USER:$DB_PASSWORD\@$DB_HOST:$DB_PORT_5432_TCP_PORT\/$DB_DATABASE?sslmode=disable\&connect_timeout=10connect_timeout=10/" /opt/mattermost/config/config.json > /tmp/config.json

cat /tmp/config.json >/opt/mattermost/config/config.json
cat /tmp/config.json |grep Data
echo "done"

exec /opt/mattermost/bin/platform
