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

echo "Done"

echo "Installing apps through apt"
sudo apt install flatpak lmms chromium-browser git -y

echo "Done"

echo "Installing wallpapers"
git clone https://github.com/Madboyz2586/Wallpapers.git /home/braydon/Pictures
sudo mv /home/braydon/Pictures/Wallpapers /usr/share/wallpapers
cd /home/braydon

echo "Done"

echo "Installing Box86"
sudo dpkg --add-architecture armhf
sudo apt install libraspberrypi0:armhf libssh-gcrypt-4:armhf libgssapi-krb5-2:armhf libkrb5-3:armhf libssl1.1:armhf libcups2:armhf libsdl1.2debian:armhf libopusfile0:armhf libc6:armhf libx11-6:armhf libgdk-pixbuf2.0-0:armhf libgtk2.0-0:armhf libstdc++6:armhf libsdl2-2.0-0:armhf mesa-va-drivers:armhf libsdl1.2-dev:armhf libsdl-mixer1.2:armhf libpng16-16:armhf libcal3d12v5:armhf libsdl2-net-2.0-0:armhf libopenal1:armhf libsdl2-image-2.0-0:armhf libvorbis-dev:armhf libcurl4:armhf osspd:armhf pulseaudio libjpeg62:armhf libudev1:armhf libgl1-mesa-dev:armhf libsnappy1v5:armhf libx11-dev:armhf libsmpeg0:armhf libboost-filesystem1.74.0:armhf libboost-program-options1.74.0:armhf libavcodec58:armhf libavformat58:armhf libswscale5:armhf libmyguiengine3debian1v5:armhf libboost-iostreams1.74.0:armhf libsdl2-mixer-2.0-0:armhf -y
sudo rm /etc/apt/sources.list.d/box86.list &>/dev/null
echo "Adding box86 repo..."
wget https://itai-nelken.github.io/weekly-box86-debs/debian/box86.list -qO- | sed -r 's/deb /deb [arch=armhf] /' | sudo tee /etc/apt/sources.list.d/box86.list >/dev/null|| error "Failed to download /etc/apt/sources.list.d/box86.list"
echo "Adding key..."
wget -qO- https://itai-nelken.github.io/weekly-box86-debs/debian/KEY.gpg | sudo apt-key add - || error "Failed to add key to box86 repo!"
echo "Installing box86..."
sudo apt install box86:armhf -y
sudo systemctl restart systemd-binfmt

echo "Done"

echo "Installing Flathub"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Done"

echo "Installing flathub apps"
flatpak install flathub org.olivevideoeditor.Olive -y
flatpak install flathub com.sublimetext.three -y
flatpak install flathub com.visualstudio.code -y
flatpak install flathub io.openrct2.OpenRCT2 -y
flatpak install flathub com.github.k4zmu2a.spacecadetpinball -y
flatpak install flathub org.srb2.SRB2Kart -y
flatpak install flathub org.srb2.SRB2 -y
flatpak install flathub org.flameshot.Flameshot -y
flatpak install flathub org.gimp.GIMP -y
flatpak install flathub org.kde.krita -y

echo "Done"
