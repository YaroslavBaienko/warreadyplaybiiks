#!/bin/bash

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

# Step 6: Add Go to PATH (you can skip this if already added in .profile)
echo 'export PATH=$PATH:/usr/local/go/bin' >> $HOME/.profile

# Step 7: Reload .profile to update PATH
source $HOME/.profile

# Step 8: Verify Go installation
go version

# Step 9: Download and install Python
wget https://www.python.org/ftp/python/3.12.7/Python-3.12.7.tgz

# Step 10: Extract Python archive
tar -xf Python-3.12.7.tgz

# Step 11: Change directory to Python source folder
cd Python-3.12.7

# Step 12: Configure Python build with optimizations
./configure --enable-optimizations

# Step 13: Compile Python using all available CPU cores
make -j $(nproc)

# Step 14: Install Python (without overwriting default Python version)
sudo make altinstall

# Step 15: Verify Python installation
python3.12 --version
