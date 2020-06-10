#!/bin/bash

apt-get update

{ cat <<EOF
bison
build-essential
ca-certificates
cmake
curl
gcc
gcc-mingw-w64
geoip-database
gnutls-bin
heimdal-dev
ike-scan
libgcrypt20-dev
libglib2.0-dev
libgnutls28-dev
libgpgme11-dev
libgpgme-dev
libhiredis-dev
libical-dev
libksba-dev
libldap2-dev
libmicrohttpd-dev
libnet-snmp-perl
libpcap-dev
libpopt-dev
libsnmp-dev
libssh-gcrypt-dev
libxml2-dev
net-tools
nmap
nsis
openssh-client
perl-base
pkg-config
redis-server
redis-tools
rsync
smbclient
texlive-fonts-recommended
texlive-latex-extra
uuid-dev
wapiti
wget
xml-twig-tools
EOF
} | xargs apt-get install -yq --no-install-recommends


rm -rf /var/lib/apt/lists/*
