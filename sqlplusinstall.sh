#!/bin/bash
## Easy script to install sqlplus on ARM64 systems (Apple Silicon and other ARM64 platforms)
## Script by: MelForze

echo "⏬ Download the required packages"
wget http://download.oracle.com/otn_software/linux/instantclient/1926000/instantclient-basic-linux.arm64-19.26.0.0.0dbru.zip
wget http://download.oracle.com/otn_software/linux/instantclient/1926000/instantclient-sqlplus-linux.arm64-19.26.0.0.0dbru.zip
wget http://download.oracle.com/otn_software/linux/instantclient/1926000/instantclient-sdk-linux.arm64-19.26.0.0.0dbru.zip

echo "📁 Create directory /opt/oracle"
sudo mkdir -p /opt/oracle

echo "📂 Unzip packages into /opt/oracle"
sudo unzip -d /opt/oracle instantclient-basic-linux.arm64-19.26.0.0.0dbru.zip
sudo unzip -d /opt/oracle instantclient-sqlplus-linux.arm64-19.26.0.0.0dbru.zip
sudo unzip -d /opt/oracle instantclient-sdk-linux.arm64-19.26.0.0.0dbru.zip

cd /opt/oracle/instantclient_19_26 && find . -type f | sort

echo "🔧 Set environment variables"
export PATH="$PATH:/opt/oracle/instantclient_19_26"
export SQLPATH="/opt/oracle/instantclient_19_26"
export TNS_ADMIN="/opt/oracle/instantclient_19_26"
export LD_LIBRARY_PATH="/opt/oracle/instantclient_19_26"
export ORACLE_HOME="/opt/oracle/instantclient_19_26"

echo "✅ Test installation"
sqlplus -V
