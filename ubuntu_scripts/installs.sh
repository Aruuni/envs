echo "Pulse audio volume control"
sudo apt install pavucontrol -y

echo "Pulseeffects (audio equalizer)"
sudo apt install pulseeffects -y
pulseeffects --load-preset ../ubuntu_scripts/defEq.json

echo "Installing VScode ..."
sudo snap install --classic code 

echo "Installing Discord ..."
sudo snap install discord
gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'discord_discord.desktop']"


echo "Installing Spotify ..."
sudo snap install spotify 
gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'spotify_spotify.desktop']"
