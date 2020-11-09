#!/usr/bin/env bash

while getopts ":e:p:" opt; do
  case $opt in
    e) env="$OPTARG"
    ;;
    p) platform="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

flutter clean

if [ ! -z "$env" ]; then
  printf "Env now: $env"
  cp -a environments/$env/.env .env
  cp -a environments/$env/google-services.json android/app/google-services.json
  cp -a environments/$env/GoogleService-Info.plist ios/Runner/GoogleService-Info.plist
  printf "\nFinish"

  if [ ! -z "$platform" ]; then
    printf "\nPlatform now: $platform\n"
    if [ "$platform" == "ios" ]; then
      rm -rf ios/Flutter/Flutter.framework
      flutter build ios --flavor $env
      printf "\nFlutter build iOS DONE\n"
      xcodebuild -workspace ios/Runner.xcworkspace -scheme $env archive
    elif [ "$platform" == "android" ]; then
      flutter build appbundle --flavor $env
    else
      printf "\nPlatform invalid.\n"
    fi
  else 
    printf "\nPlatform must be set.\n"
  fi
else
  printf "\nEnvironment must be set.\n"
fi

