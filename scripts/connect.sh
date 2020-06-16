#!/usr/bin/env bash
set -Eeuo pipefail

MASTER_PORT=${MASTER_PORT:-22}

until ssh -N -T -i /data/ssh/key -o UserKnownHostsFile=/data/ssh/known_hosts -p $MASTER_PORT -R /data/ospd.sock:/sockets/$HOSTNAME.sock gvm@$MASTER_ADDRESS; do
	echo "Connection disrupted, retrying in 10 seconds..." >> /usr/local/var/log/gvm/ssh-connection.log
	sleep 10
done
