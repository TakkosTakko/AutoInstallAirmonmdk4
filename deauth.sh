#!/bin/bash

# Begrüßung
echo "Willkommen zum Autoinstaller zum DeAuthen von WPA2/WPA3 Netzwerken!"
echo " "

echo "  _____                     _   _                                                                                "
echo " |  __ \         /\        | | | |                                                                               "
echo " | |  | | ___   /  \  _   _| |_| |__                                                                            "
echo " | |  | |/ _ \ / /\ \| | | | __| '_ \                                                                           "
echo " | |__| |  __// ____ \ |_| | |_| | | |                                                                          "
echo " |_____/ \___/_/  _ \_\__,_|\__|_| |_|   _               _             ______     _ _  __           _    _       "
echo " |_   _|         | |      | | |     | | (_)             | |           |  ____|   (_) |/ /          | |  (_)      "
echo "   | |  _ __  ___| |_ __ _| | | __ _| |_ _  ___  _ __   | |__  _   _  | |____   ___| ' / ___   ___ | | ___  ___  "
echo "   | | | '_ \/ __| __/ _` | | |/ _` | __| |/ _ \| '_ \  | '_ \| | | | |  __\ \ / / |  < / _ \ / _ \| |/ / |/ _ \ "
echo "  _| |_| | | \__ \ || (_| | | | (_| | |_| | (_) | | | | | |_) | |_| | | |___\ V /| | . \ (_) | (_) |   <| |  __/ "
echo " |_____|_| |_|___/\__\__,_|_|_|\__,_|\__|_|\___/|_| |_| |_.__/ \__, | |______\_/ |_|_|\_\___/ \___/|_|\_\_|\___|" 
echo"                                                           __/ |                                            "
echo"                                                          |___/                                             "

# Abfrage, ob der Code ausgeführt werden soll
read -p "Möchtest du die Installation ausführen? (ja/nein): " execute

# Überprüfen der Benutzereingabe
if [[ "$execute" == "ja" ]]; then
    echo "Installation wird ausgeführt..."
    echo "Anmeldung als root" 
	sudo su -i root   
	
	#Installieren des Dependencies
    echo "Installation von den Dependencies"
	sudo apt install autoconf automake libpcre3-dev libnl-3-dev libsqlite3-dev libssl-dev ethtool build-essential g++ libnl-genl-3-dev libgcrypt20-dev libtool python3-distutils
        sudo apt install -y pkg-config
    # Installation der benötigten Pakete
    echo "Updaten des Servers"
    sudo apt-get update
    
    echo "Installieren von aircrack-ng"
    sudo apt-get install -y aircrack-ng
apt install git
git clone https://github.com/aircrack-ng/aircrack-ng.git
cd aircrack-ng
sudo autoreconf -i
sudo ./configure --with-experimental --with-ext-scripts 
sudo make 
sudo make install
sudo airodump-ng-oui-update
        echo "Installieren von mdk4 && mdk3"
    sudo apt-get install -y mdk4 mdk3

    echo "Installation abgeschlossen. Server muss neugestartet werden!"
else
    echo "Code wird nicht ausgeführt. Skript wird beendet."
fi
