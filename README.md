Easysqlplusinstall

A versatile Bash script to install Oracle SQL*Plus on ARM64-based systems (macOS on Apple Silicon, Linux distributions, WSL with ARM64) seamlessly.

Repository: https://github.com/MelForze/sqlplusinstall

🚀 Features
	•	Supports any ARM64 (AARCH64) platform, including macOS (M1, M2, M3), popular ARM64 Linux distros (Ubuntu, Debian, Fedora) and WSL on ARM64 Windows
	•	Automatically downloads the required Oracle Instant Client packages
	•	Installs into /opt/oracle by default
	•	Configures environment variables for immediate sqlplus usage
	•	Minimal dependencies: bash, wget, unzip, sudo

🛠️ Prerequisites
	•	ARM64 (AARCH64) hardware platform
	•	Operating system:
	•	macOS (Apple Silicon)
	•	Linux distributions for ARM64 (Ubuntu, Debian, Fedora, CentOS)
	•	WSL2 on Windows Arm64
	•	Installed command-line tools:
	•	bash
	•	wget
	•	unzip
	•	sudo

📥 Installation
	1.	Clone the repository and enter its directory:

git clone https://github.com/MelForze/sqlplusinstall.git
cd sqlplusinstall
chmod +x sqlplusinstall.sh


	2.	Run the installer script:

./sqlplusinstall.sh


	3.	Follow the on-screen prompts. The script will:
	•	Download Instant Client ZIPs for ARM64
	•	Create /opt/oracle directory
	•	Extract packages into /opt/oracle/instantclient_19_26
	•	Set up environment variables
	•	Verify the sqlplus installation

📄 Script: sqlplusinstall.sh

#!/usr/bin/env bash
# Installer for Oracle SQL*Plus on ARM64 (AARCH64) systems
# Author: MelForze

set -e

echo "⏬ Downloading Oracle Instant Client packages..."
wget https://download.oracle.com/otn_software/linux/instantclient/1926000/instantclient-basic-linux.arm64-19.26.0.0.0dbru.zip
wget https://download.oracle.com/otn_software/linux/instantclient/1926000/instantclient-sqlplus-linux.arm64-19.26.0.0.0dbru.zip
wget https://download.oracle.com/otn_software/linux/instantclient/1926000/instantclient-sdk-linux.arm64-19.26.0.0.0dbru.zip

echo "📁 Creating target directory /opt/oracle"
sudo mkdir -p /opt/oracle

echo "📂 Extracting Instant Client archives"
sudo unzip -o instantclient-basic-linux.arm64-19.26.0.0.0dbru.zip -d /opt/oracle
sudo unzip -o instantclient-sqlplus-linux.arm64-19.26.0.0.0dbru.zip -d /opt/oracle
sudo unzip -o instantclient-sdk-linux.arm64-19.26.0.0.0dbru.zip -d /opt/oracle

CLIENT_DIR="/opt/oracle/instantclient_19_26"

echo "🔍 Listing installed files"
find "$CLIENT_DIR" -maxdepth 1 | sort

echo "🔧 Configuring environment variables"
export PATH="$PATH:$CLIENT_DIR"
export SQLPATH="$CLIENT_DIR"
export TNS_ADMIN="$CLIENT_DIR"
export LD_LIBRARY_PATH="$CLIENT_DIR"
export ORACLE_HOME="$CLIENT_DIR"

# Optionally persist settings
PROFILE_FILE="$HOME/.bashrc"
if [[ -w "$PROFILE_FILE" ]]; then
  echo "# Oracle Instant Client variables" >> "$PROFILE_FILE"
  echo "export PATH=\"\\$PATH:$CLIENT_DIR\"" >> "$PROFILE_FILE"
  echo "export SQLPATH=\"$CLIENT_DIR\"" >> "$PROFILE_FILE"
  echo "export TNS_ADMIN=\"$CLIENT_DIR\"" >> "$PROFILE_FILE"
  echo "export LD_LIBRARY_PATH=\"$CLIENT_DIR\"" >> "$PROFILE_FILE"
  echo "export ORACLE_HOME=\"$CLIENT_DIR\"" >> "$PROFILE_FILE"
  echo "Persistence enabled in $PROFILE_FILE"
fi

echo "✅ Testing sqlplus installation"
sqlplus -V

⚙️ Environment Variables
	•	PATH — locate sqlplus executable
	•	SQLPATH — SQL*Plus configuration path
	•	TNS_ADMIN — Oracle Net configuration files
	•	LD_LIBRARY_PATH — Instant Client libraries
	•	ORACLE_HOME — Instant Client root directory

To apply these variables permanently, ensure your shell profile (e.g., ~/.bashrc, ~/.zshrc) sources the above exports.

🎉 Verification

Run:

sqlplus -V

Expected output:

SQL*Plus: Release 19.0.0.0.0 - Production


⸻

Script Author: MelForze
