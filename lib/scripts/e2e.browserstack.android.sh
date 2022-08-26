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

  echo "$(yellow find the build at: $ANDROID_FOLDER_PATH/app/build/outputs/apk/$ANDROID_TARGET/release/app-$ANDROID_TARGET-release-unsigned.apk)"
fi

if [ "$1" == "--run" ]
then
  echo "$(yellow 🔧 upload .apk)"

  RESULT=$(curl -u "$BS_USER:$BS_KEY" -X POST "https://api-cloud.browserstack.com/app-automate/upload" -F "file=@$ANDROID_FOLDER_PATH/app/build/outputs/apk/$ANDROID_TARGET/release/app-$ANDROID_TARGET-release-unsigned.apk")

  export BS_PATH=$(node -pe 'JSON.parse(process.argv[1]).app_url' $RESULT)

  if [ "$2" == "--spec" ]; then
      FIX_SPEC_PATH=$(node -pe '(".build/"+process.argv[1].slice(process.argv[1].indexOf("__e2e__"))).replace(".ts",".js")' $(realpath $3))
  fi

  npx wdio configs/wdio.local.conf.js $2 $FIX_SPEC_PATH
fi