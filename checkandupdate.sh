#!/bin/bash
appid=<STEAM APPID GOES HERE>

last_detected_version_file="$appid"_buildid.txt

function jsonValue() {
    KEY=$1
    num=$2
    awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/'$KEY'\042/){print $(i+1)}}}' | tr -d '"' | sed -n ${num}p | xargs
}

new_game_version=$(curl -s -X GET "https://api.steamcmd.net/v1/info/$appid" | jsonValue buildid 1)

if [ ! -f "$last_detected_version_file" ]; then
    previous_game_version="0"
else
    previous_game_version="$(cat "$last_detected_version_file" | xargs)"
fi
echo "$new_game_version" > "$last_detected_version_file"

if [ ! "$previous_game_version" == "$new_game_version" ]; then
    updateserver=true
fi

echo "previous version detected: $previous_game_version"
echo "new version detected: $new_game_version"

if [ $updateserver == true ]; then
    echo "Run server update command"
    <INSERT SERVER UPDATE COMMAND>
    <INSERT SERVER RESTART COMMAND>
fi
