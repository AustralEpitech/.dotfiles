#!/bin/bash
set -e

function get_value() {
    local to="$1"
    local from="$2"

    curl "$API$from$to" 2> /dev/null | jq -r .price
}

if [ -t 1 ]; then
    NORMAL='\e[0m'
    BOLD='\e[1m'
fi

API='https://api.binance.com/api/v3/avgPrice?symbol='

DELIM='='
TO=EUR

# COIN=VALUE
WALLET="${XDG_CONFIG_HOME-"$HOME"/.config}/crypto/wallet"

TOTAL=0
while read -r line; do
    COIN="$(echo "$line" | cut -d "$DELIM" -f 1)"
    QTY="$(echo "$line" | cut -d "$DELIM" -f 2)"

    MARKET="$(get_value "$TO" "$COIN")"
    VALUE="$(echo "$MARKET* $QTY" | bc)"
    TOTAL="$(echo "$TOTAL + $VALUE" | bc)"

    printf "${BOLD}${COIN}${NORMAL}=%.2f€ " "$VALUE"
done < "$WALLET"

printf "${BOLD}TOT${NORMAL}=%.2f€\n" "$TOTAL"
