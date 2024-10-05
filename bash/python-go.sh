#!/bin/bash

# Step 0: Create a temp directory in the home folder
mkdir -p $HOME/temp
cd $HOME/temp

# Step 1: Update package lists
sudo apt-get update

# Step 2: Install required build tools and libraries
sudo apt-get install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev \
libreadline-dev libffi-dev libsqlite3-dev wget pkg-config

# Step 3: Download and install Go
wget https://go.dev/dl/go1.23.2.linux-amd64.tar.gz

# Step 4: Check if /usr/local/go exists and remove it
if [ -d "/usr/local/go" ]; then
    sudo rm -rf /usr/local/go
fi

# Step 5: Extract Go archive and install it
sudo tar -C /usr/local -xzf go1.23.2.linux-amd64.tar.gz

# Step 6: Add Go to PATH (for current and future sessions)
if ! grep -q '/usr/local/go/bin' "$HOME/.profile"; then
    echo 'export PATH=$PATH:/usr/local/go/bin' >> $HOME/.profile
fi

# Ensure Go is available in future sessions
echo 'export PATH=$PATH:/usr/local/go/bin' | tee -a ~/.bashrc

# Step 7: Reload .profile to update PATH in current session
source $HOME/.profile

# Step 8: Verify Go installation
go version

# Step 9: Check if Python version 3.12.7 is already installed and working
if python3.12 --version &> /dev/null; then
    echo "Python 3.12.7 is already installed and working."
else
    echo "Installing or repairing Python 3.12.7..."
    # Step 9a: Download Python
    wget https://www.python.org/ftp/python/3.12.7/Python-3.12.7.tgz

    # Step 9b: Extract Python archive
    tar -xf Python-3.12.7.tgz

    # Step 9c: Change directory to Python source folder
    cd Python-3.12.7

    # Step 9d: Configure Python build with optimizations
    ./configure --enable-optimizations

    # Step 9e: Compile Python using all available CPU cores
    make -j $(nproc)

    # Step 9f: Install Python (without overwriting default Python version)
    sudo make altinstall
fi

# Step 10: Verify Python installation
python3.12 --version

# Optional: Clean up the temp directory
cd $HOME
rm -rf $HOME/temp
