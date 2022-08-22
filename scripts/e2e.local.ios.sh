#!/bin/bash

# Load common
. scripts/common.sh

if [ "$1" == "--build" ]; then
    echo "$(yellow 🔧 build $IOS_PRODUCT simulator)"

    xcodebuild -workspace $IOS_WORKSPACE -scheme $IOS_SCHEME -destination "platform=iOS Simulator,name=iPhone 13" clean build
fi

if [ "$1" == "--run" ]; then
    export IOS_APP_PATH=$(find ~/Library/Developer/XCode/DerivedData/$(basename $IOS_WORKSPACE .xcworkspace)*/Build -name "*.app")

    echo "$(yellow 🔧 IOS_APP_PATH=$IOS_APP_PATH)"

    if [ -z "$IOS_APP_PATH" ]; then
        echo "$(yellow 🔧 Cannot find the build/s)"
    else
        echo "$(yellow 🔧 run wdio .ipa)"
        npx wdio configs/wdio.local.conf.js
    fi
fi
