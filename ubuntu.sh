#!/bin/bash

echo "Setting up monitors..."
bash ubuntu_scripts/monitor_setup.sh

echo "Installing applications..."
sudo apt install pauvcontrol -y

echo "Pulseeffects (audio equalizer)"
sudo apt install pulseeffects -y
pulseeffects --load-preset ubuntu_scripts/defEq.json

echo "vscode"
sudo snap install --classic code 