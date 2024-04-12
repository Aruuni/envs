#!/bin/bash

echo "Setting up monitors..."
bash ubuntu_scripts/monitor_setup.sh

echo "Installing applications..."
bash ubuntu_scripts/installs.sh

echo "Updating appearance..."
bash ubuntu_scripts/appearance.sh