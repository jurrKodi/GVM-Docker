#!/bin/bash

apt-get update

apt-get install -y gnupg curl

echo "deb http://apt.postgresql.org/pub/repos/apt focal-pgdg main" > /etc/apt/sources.list.d/pgdg.list
curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

apt-get update

{ cat <<EOF
build-essential
cmake
gcc
libglib2.0-dev
libgnutls28-dev
libgpgme11-dev
libgpgme-dev
libhiredis-dev
libical-dev
libldap2-dev
libpcap-dev
libssh-gcrypt-dev
libxml2-dev
pkg-config
postgresql-10
postgresql-12
postgresql-server-dev-10
postgresql-server-dev-12
uuid-dev
wget
xml-twig-tools
EOF
} | xargs apt-get install -yq --no-install-recommends


rm -rf /var/lib/apt/lists/*
