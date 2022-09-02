#!/bin/bash

# Load common
. lib/scripts/common.sh

if [ "$1" == "--build" ]; then
  rm -rf $(pwd)/tmp/ios

  echo "$(yellow 🔧 build $IOS_PRODUCT archive)"
  xcodebuild -workspace $IOS_WORKSPACE -scheme $IOS_SCHEME -archivePath $(pwd)/tmp/ios/ios_e2e_archive.xcarchive archive

  echo "$(yellow 🔧 create $IOS_PRODUCT.ipa)"
  xcodebuild -exportArchive -archivePath $(pwd)/tmp/ios/ios_e2e_archive.xcarchive -exportPath $(pwd)/tmp/ios/xcode-export -exportOptionsPlist $(pwd)/$EXPORT_PLIST_OPTIONS

  echo "$(yellow find the build at: $(pwd)/tmp/ios/xcode-export/$IOS_PRODUCT.ipa)"
fi

if [ "$1" == "--run" ]; then
  echo "$(yellow 🔧 upload .ipa)"

  RESULT=$(curl -u "$BS_USER:$BS_KEY" -X POST "https://api-cloud.browserstack.com/app-automate/upload" -F "file=@tmp/ios/xcode-export/$IOS_PRODUCT.ipa")

  export BS_PATH=$(node -pe 'JSON.parse(process.argv[1]).app_url' "$RESULT")

  if [ "$2" == "--spec" ]; then
    FIX_SPEC_PATH=$(node -pe '(".build/"+process.argv[1].slice(process.argv[1].indexOf("__e2e__"))).replace(".ts",".js")' $(realpath $3))
  fi

  npx wdio configs/wdio.browserstack.ios.conf.js $2 $FIX_SPEC_PATH
fi
