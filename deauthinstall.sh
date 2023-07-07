#!/bin/bash

# Begrüßung
echo "Willkommen zum Autoinstaller zum DeAuthen von WPA2/WPA3 Netzwerken!"
echo "JUST for Educational things donst use it for cracking its illegal"
echo "JUST for Educational things donst use it for cracking its illegal"
echo "JUST for Educational things donst use it for cracking its illegal"
echo "JUST for Educational things donst use it for cracking its illegal"
echo "JUST for Educational things donst use it for cracking its illegal"
echo " "

echo "  _____                     _   _                                                                                "
echo " |  __ \         /\        | | | |                                                                               "
echo " | |  | | ___   /  \  _   _| |_| |__                                                                            "
echo " | |  | |/ _ \ / /\ \| | | | __| '_ \                                                                           "
echo " | |__| |  __// ____ \ |_| | |_| | | |                                                                          "
echo " |_____/ \___/_/  _ \_\__,_|\__|_| |_|   _               _             ______     _ _  __           _    _       "
echo " |_   _|         | |      | | |     | | (_)             | |           |  ____|   (_) |/ /          | |  (_)      "
echo "   | |  _ __  ___| |_ __ _| | | __ _| |_ _  ___  _ __   | |__  _   _  | |____   ___| ' / ___   ___ | | ___  ___  "
echo "   | | | '_ \/ __| __/ _` I I I/ _` | __| |/ _ \| '_ \  | '_ \| | | | |  __\ \ / / |  < / _ \ / _ \| |/ / |/ _ \ "
echo "  _| |_| | | \__ \ || (_| | | | (_| | |_| | (_) | | | | | |_) | |_| | | |___\ V /| | . \ (_) | (_) |   <| |  __/ "
echo " |_____|_| |_|___/\__\__,_|_|_|\__,_|\__|_|\___/|_| |_| |_.__/ \__, | |______\_/ |_|_|\_\___/ \___/|_|\_\_|\___|" 
echo "                                                          __/ |                                            "
echo "                                                         |___/                                             "

read -p "Möchtest du die Installation ausführen? (ja/nein): " execute

if [[ "$execute" == "ja" ]]; then
  
	
    echo "Installation von den Dependencies"
	sudo apt install autoconf automake libpcre3-dev libnl-3-dev libsqlite3-dev libssl-dev ethtool build-essential g++ libnl-genl-3-dev libgcrypt20-dev libtool python3-distutils
    sudo apt install -y pkg-config

    echo "Updaten des Servers"
    sudo apt-get update && apt-get upgrade -y
    
    echo "Installieren von aircrack-ng"
    sudo apt-get install -y aircrack-ng
    sudo apt install git
    sudo git clone https://github.com/aircrack-ng/aircrack-ng.git
     cd aircrack-ng
    sudo autoreconf -i
    sudo ./configure --with-experimental --with-ext-scripts 
    sudo make 
    sudo make install
    sudo airodump-ng-oui-update
    echo "Installieren von mdk4 && mdk3"
    sudo apt-get install -y mdk4 mdk3

    echo "Installieren von Netzwerktreiber (RTL8812AU)"
    sudo apt-get install dkms
    sudo git clone -b v5.6.4.2 https://github.com/aircrack-ng/rtl8812au.git
    sudo cd rtl*
    sudo make dkms_install
     sudo make && sudo make install
    sudo apt-get update
    sudo apt-get install bc mokutil build-essential libelf-dev linux-headers-`uname -r`

    echo "Installation abgeschlossen. Server muss neugestartet werden!"
else
    echo "Fehler beim Ausführen des Skripts, Skript wird beendet."
fi
