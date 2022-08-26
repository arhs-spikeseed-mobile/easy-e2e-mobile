#!/bin/bash

# Load common
. lib/scripts/common.sh

if [ "$1" == "--build" ]
then
  rm -rf $ANDROID_FOLDER_PATH/app/build

  echo "$(yellow 🔧 build/create $ANDROID_PRODUCT#$ANDROID_TARGET apk)"

  cd $ANDROID_FOLDER_PATH
  chmod 777 ./gradlew
  ./gradlew "assemble$ANDROID_TARGET"
  cd ..

  echo "$(yellow find the build at: $ANDROID_FOLDER_PATH/app/build/outputs/apk/$ANDROID_TARGET/debug/app-$ANDROID_TARGET-debug.apk)"
fi

if [ "$1" == "--run" ]; then
    export ANDROID_APP_PATH=$(find $ANDROID_FOLDER_PATH/app/build/outputs/apk/**/debug/** -name "*.apk")

    echo "$(yellow 🔧 ANDROID_APP_PATH=$ANDROID_APP_PATH)"

    if [ -z "$ANDROID_APP_PATH" ]; then
        echo "$(yellow 🔧 Cannot find the build/s)"
    else
        echo "$(yellow 🔧 run wdio .apk)"
        
        if [ "$2" == "--spec" ]; then
            FIX_SPEC_PATH=$(node -pe '(".build/"+process.argv[1].slice(process.argv[1].indexOf("__e2e__"))).replace(".ts",".js")' $(realpath $3))
        fi

        npx wdio configs/wdio.local.conf.js $2 $FIX_SPEC_PATH
    fi
fi
