# sqlplusinstall

GitHub Repository: [MelForze/easysqlplusinstall](https://github.com/MelForze/sqlplusinstall)

A versatile Bash script to install Oracle SQL\*Plus on ARM64 systems, including Apple Silicon macOS (M-series) and other ARM64-based Linux distributions.

## 🚀 Features

* **ARM64 Support**: Compatible with Apple M1/M2/M3 Macs and ARM64 Linux environments.
* **Automatic Download**: Fetches required Oracle Instant Client packages.
* **Easy Installation**: Unpacks to `/opt/oracle` and sets up environment variables.
* **Cross-Platform**: Works on macOS and Linux on ARM64.

## 🛠️ Prerequisites

* An ARM64-based system (e.g., Apple Silicon Mac or ARM64 Linux)
* Installed commands:

  * `bash`
  * `wget`
  * `unzip`
  * `sudo`

## 📥 Installation

1. **Clone the repository**:

   ```bash
   git clone https://github.com/MelForze/sqlplusinstall.git
   cd sqlplusinstall
   ```

2. **Make the script executable**:

   ```bash
   chmod +x sqlplusinstall.sh
   ```

3. **Run the installer**:

   ```bash
   ./sqlplusinstall.sh
   ```

4. **Follow on-screen prompts**. The script will download, extract, and configure Oracle Instant Client.

## 📝 Script Content (`sqlplusinstall.sh`)

```bash
#!/bin/bash
# sqlplusinstall.sh
# A simple script to install Oracle SQL*Plus on ARM64 systems (macOS & Linux)
# Author: MelForze

set -e

echo "⏬ Downloading Oracle Instant Client packages..."
PACKAGES=(
  "instantclient-basic-linux.arm64-19.26.0.0.0dbru.zip"
  "instantclient-sqlplus-linux.arm64-19.26.0.0.0dbru.zip"
  "instantclient-sdk-linux.arm64-19.26.0.0.0dbru.zip"
)
BASE_URL="https://download.oracle.com/otn_software/linux/instantclient/1926000"

for pkg in "${PACKAGES[@]}"; do
  echo "Downloading $pkg"
  wget --progress=dot:giga "$BASE_URL/$pkg"
done

INSTALL_DIR="/opt/oracle"
echo "📁 Creating directory $INSTALL_DIR"
sudo mkdir -p "$INSTALL_DIR"

echo "📂 Extracting packages to $INSTALL_DIR"
for pkg in "${PACKAGES[@]}"; do
  sudo unzip -o -d "$INSTALL_DIR" "$pkg"
done

cd "$INSTALL_DIR/instantclient_19_26"

echo "🔧 Setting environment variables..."
# Update PATH and Oracle vars
ENV_VARS=(
  "PATH=$PATH:$INSTALL_DIR/instantclient_19_26"
  "SQLPATH=$INSTALL_DIR/instantclient_19_26"
  "TNS_ADMIN=$INSTALL_DIR/instantclient_19_26"
  "LD_LIBRARY_PATH=$INSTALL_DIR/instantclient_19_26"
  "ORACLE_HOME=$INSTALL_DIR/instantclient_19_26"
)

for var in "${ENV_VARS[@]}"; do
  export "$var"
done

echo "✅ Testing installation..."
sqlplus -V

echo "Installation complete!"
```

## ⚙️ Environment Variables

The script sets the following variables for the current session:

* `PATH`: Includes Instant Client binaries.
* `SQLPATH`: Points to SQL\*Plus directory.
* `TNS_ADMIN`: For Oracle Net configuration.
* `LD_LIBRARY_PATH`: For loading Instant Client libraries.
* `ORACLE_HOME`: Root directory of the Instant Client.

To persist these across sessions, add them to your shell profile (e.g., `~/.bash_profile` or `~/.zshrc`).

## 🎉 Verification

Run:

```bash
sqlplus -V
```

You should see the SQL\*Plus version information if everything is set up correctly.

---

**Author**: MelForze
