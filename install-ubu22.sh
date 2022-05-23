#!/bin/bash
echo "removing snap firefox and installing ppa firefox"

sudo snap remove firefox

sudo add-apt-repository ppa:mozillateam/ppa

echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozilla-firefox

echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

sudo apt install firefox

echo "Done"

echo "Installing pi-apps and pi-kiss"

echo "Installing pi-apps"
wget -qO- https://raw.githubusercontent.com/Botspot/pi-apps/master/install | bash

echo "Installing pi-kiss"
curl -sSL https://git.io/JfAPE | bash

echo "Installing apps through apt"
sudo apt install flatpak lmms krita chromium-browser git -y

echo "Installing wallpapers"
git clone https://github.com/Madboyz2586/Wallpapers.git /home/braydon/Pictures
sudo mv /home/braydon/Pictures/Wallpapers /usr/share/wallpapers
cd /home/braydon

echo "Installing Box86"
sudo dpkg --add-architecture armhf
sudo apt install libraspberrypi0:armhf libssh-gcrypt-4:armhf libgssapi-krb5-2:armhf libkrb5-3:armhf libssl1.1:armhf libcups2:armhf libsdl1.2debian:armhf libopusfile0:armhf libc6:armhf libx11-6:armhf libgdk-pixbuf2.0-0:armhf libgtk2.0-0:armhf libstdc++6:armhf libsdl2-2.0-0:armhf mesa-va-drivers:armhf libsdl1.2-dev:armhf libsdl-mixer1.2:armhf libpng16-16:armhf libcal3d12v5:armhf libsdl2-net-2.0-0:armhf libopenal1:armhf libsdl2-image-2.0-0:armhf libvorbis-dev:armhf libcurl4:armhf osspd:armhf pulseaudio libjpeg62:armhf libudev1:armhf libgl1-mesa-dev:armhf libsnappy1v5:armhf libx11-dev:armhf libsmpeg0:armhf libboost-filesystem1.67.0:armhf libboost-program-options1.67.0:armhf libavcodec58:armhf libavformat58:armhf libswscale5:armhf libmyguiengine3debian1v5:armhf libboost-iostreams1.67.0:armhf libsdl2-mixer-2.0-0:armhf -y
sudo rm /etc/apt/sources.list.d/box86.list &>/dev/null
echo "Adding box86 repo..."
wget https://itai-nelken.github.io/weekly-box86-debs/debian/box86.list -qO- | sed -r 's/deb /deb [arch=armhf] /' | sudo tee /etc/apt/sources.list.d/box86.list >/dev/null|| error "Failed to download /etc/apt/sources.list.d/box86.list"
echo "Adding key..."
wget -qO- https://itai-nelken.github.io/weekly-box86-debs/debian/KEY.gpg | sudo apt-key add - || error "Failed to add key to box86 repo!"
echo "Installing box86..."
sudo apt install box86:armhf -y
sudo systemctl restart systemd-binfmt
