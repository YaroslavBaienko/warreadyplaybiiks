#!/bin/bash

# Step 0: Create a temp directory in the home folder
mkdir -p $HOME/temp
cd $HOME/temp

# Step 1: Update package lists
sudo apt-get update

# Step 2: Install required build tools and libraries
sudo apt-get install -y git vim ansible build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev \
libreadline-dev libffi-dev libsqlite3-dev wget pkg-config

# Step 3: Download and install Go
wget https://go.dev/dl/go1.23.2.linux-amd64.tar.gz

# Step 4: Check if /usr/local/go exists and remove it
if [ -d "/usr/local/go" ]; then
    sudo rm -rf /usr/local/go
fi

# Step 5: Extract Go archive and install it
sudo tar -C /usr/local -xzf go1.23.2.linux-amd64.tar.gz

# Step 6: Add Go to PATH in .bashrc
if ! grep -q 'export PATH=\$PATH:/usr/local/go/bin' "$HOME/.bashrc"; then
    echo 'export PATH=$PATH:/usr/local/go/bin' >> $HOME/.bashrc
fi

# Manually export PATH for immediate use in the script
export PATH=$PATH:/usr/local/go/bin

# Step 7: Verify Go installation using the full path
/usr/local/go/bin/go version

# Step 8: Check if Python version 3.12.7 is already installed and working
if python3.12 --version &> /dev/null; then
    echo "Python 3.12.7 is already installed and working."
else
    echo "Installing or repairing Python 3.12.7..."
    # Step 8a: Download Python
    wget https://www.python.org/ftp/python/3.12.7/Python-3.12.7.tgz

    # Step 8b: Extract Python archive
    tar -xf Python-3.12.7.tgz

    # Step 8c: Change directory to Python source folder
    cd Python-3.12.7

    # Step 8d: Configure Python build with optimizations
    ./configure --enable-optimizations

    # Step 8e: Compile Python using all available CPU cores
    make -j $(nproc)

    # Step 8f: Install Python (without overwriting default Python version)
    sudo make altinstall
fi

# Step 9: Verify Python installation
python3.12 --version

# Optional: Clean up the temp directory
cd $HOME
rm -rf $HOME/temp
