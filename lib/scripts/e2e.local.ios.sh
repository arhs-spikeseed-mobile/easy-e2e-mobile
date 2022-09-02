#!/bin/bash

# Load common
. lib/scripts/common.sh

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

        if [ "$2" == "--spec" ]; then
            FIX_SPEC_PATH=$(node -pe '(".build"+process.argv[2].slice(process.argv[1].length).replace(".ts",".js"))' $(dirname $(realpath $E2E_SPECS_PATH)) $(realpath $3))
        fi

        npx wdio configs/wdio.local.conf.js $2 $FIX_SPEC_PATH
    fi
fi
