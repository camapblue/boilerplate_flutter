#!/usr/bin/env bash

while getopts ":e:d:" opt; do
  case $opt in
    e) env="$OPTARG"
    ;;
    d) device="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

if [ ! -z "$env" ]; then
  printf "Env now: $env"
  cp -a environments/$env/.env .env
  cp -a environments/$env/google-services.json android/app/google-services.json
  cp -a environments/$env/GoogleService-Info.plist ios/Runner/GoogleService-Info.plist
  printf "\nFinish\n"
  if [ ! -z "$device" ]; then
    printf "Device : $device"
    flutter run --flavor $env -d $device
  else
    flutter run --flavor $env
  fi
else
  flutter run
fi

