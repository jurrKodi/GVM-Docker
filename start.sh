#!/usr/bin/env bash
set -Eeuo pipefail

if  [ ! -d /data/database ]; then
	echo "Error: Database folder: \"/data/database\" not found"
	exit 1
fi

echo "Creating Backup"
mkdir -p /data/database_backups/$(date --iso-8601="minutes")
cp -r /data/database/* /data/database_backups/$(date --iso-8601="minutes")/

echo "Moving /data/database to /data/old_database"
mv /data/database /data/old_database


chown postgres:postgres -R /data/old_database

echo "Creating New Database folder..."
mkdir /data/database
chown postgres:postgres -R /data/database
su -c "/usr/lib/postgresql/12/bin/initdb /data/database" postgres

cp /data/database/postgresql.conf /data/old_database/postgresql.conf
cp /data/database/pg_hba.conf /data/old_database/pg_hba.conf

chown postgres:postgres -R /data/old_database

echo "Starting PostgreSQL 10..."
su -c "/usr/lib/postgresql/10/bin/pg_ctl -D /data/old_database start" postgres

sleep 5

echo "Stoping PostgreSQL 10..."
su -c "/usr/lib/postgresql/10/bin/pg_ctl -D /data/old_database stop" postgres

sleep 5

echo "Starting PostgreSQL 12..."
su -c "/usr/lib/postgresql/12/bin/pg_ctl -D /data/database start" postgres

sleep 5

echo "Stoping PostgreSQL 12..."
su -c "/usr/lib/postgresql/12/bin/pg_ctl -D /data/database stop" postgres

sleep 5

cd /var/log/postgresql
su -c "/usr/lib/postgresql/12/bin/pg_upgrade --old-bindir=/usr/lib/postgresql/10/bin --new-bindir=/usr/lib/postgresql/12/bin --old-datadir=/data/old_database --new-datadir=/data/database" postgres

echo "Removing temp old_database folder"
rm -rf /data/old_database
