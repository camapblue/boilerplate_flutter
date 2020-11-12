#!/usr/bin/env bash

while getopts ":e:" opt; do
  case $opt in
    e) env="$OPTARG"
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

  flutter run -t storybook/lib/main.dart --flavor $env
else
  printf "Env now: dev"
  cp -a environments/dev/.env .env
  cp -a environments/dev/google-services.json android/app/google-services.json
  cp -a environments/dev/GoogleService-Info.plist ios/Runner/GoogleService-Info.plist

  flutter run -t storybook/lib/main.dart --flavor dev
fi
