#!/bin/bash -x

DB_HOST=${DB_HOST:-postgresql}
DB_PORT_5432_TCP_PORT=${DB_PORT_5432_TCP_PORT:-5432}
MM_USERNAME=${DB_USER:-mmuser}
MM_PASSWORD=${DB_PASSWORD:-mostest}
MM_DBNAME=${DB_DATABASE:-mattermost}

echo -ne "Configure PostgresSQL database connection..."

<<<<<<< HEAD
#sed "s/MATTERMOST_DATASOURCE_REPLACE/$DB_USER:$DB_PASSWORD\@$DB_HOST:$DB_PORT_5432_TCP_PORT\/$DB_DATABASE?sslmode=disable\&connect_timeout=10connect_timeout=10/" /opt/mattermost/config/config.json > /tmp/config.json
sed "s/MATTERMOST_DATASOURCE_REPLACE/$DB_USER:$DB_PASSWORD\@$DB_HOST:$DB_PORT_5432_TCP_PORT\/$DB_DATABASE?sslmode=disable\&connect_timeout=10connect_timeout=10/" /opt/mattermost/config/config.json > /tmp/config.json
=======
sed "s/MATTERMOST_DATASOURCE_REPLACE/$DB_USER:$DB_PASSWORD\@$DB_HOST:$DB_PORT_5432_TCP_PORT\/$DB_DATABASE?sslmode=disable\&connect_timeout=10/" /opt/mattermost/config/config.json > /tmp/config.json
>>>>>>> 410341bc17266eba022937bafe7b8ffa52fe2202

cp /opt/mattermost/config/config.json /tmp/config.json.org
cat /tmp/config.json >/opt/mattermost/config/config.json
cat /tmp/config.json.org |grep -i data
echo "done"

exec /opt/mattermost/bin/platform
