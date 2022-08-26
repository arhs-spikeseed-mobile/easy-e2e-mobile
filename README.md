# Easy E2E Mobile

Easy E2E Mobile is a collection of shell scripts and configurations created to quickly setup mobile e2e testing.
It supports local and cloud e2e testing through BrowserStack.

## Getting Started

1. Download and extract a copy of this project

2. Rename the file `configs/.env.template` to `configs/.env` and fill the configuration variables

3. iOS only: Create the file `configs/export_options.plist`

4. _Optional_: Edit the WebdriverIO configs located in the `configs` folder

5. _Optional_: Add a prebuild script, check `package.json` `scripts` section.

6. Run one of the available scripts

## Available scripts

- `e2e:local:build:ios` - Build the iOS app for local e2e testing
- `e2e:local:build:android` - Build the Android app for local e2e testing
- `e2e:local:run:ios` - Run Local iOS e2e testing, pass `--spec path/to/spec` to run a specific test
- `e2e:local:run:android` - Run Local Android e2e testing, pass `--spec path/to/spec` to run a specific test
- `e2e:browserstack:build:ios` - Build the iOS app for remote BrowserStack e2e testing
- `e2e:browserstack:build:android` - Build the Android app for remote BrowserStack e2e testing
- `e2e:browserstack:run:ios` - Run remote BrowserStack iOS e2e testing, pass `--spec path/to/spec` to run a specific test
- `e2e:browserstack:run:android` - Run remote BrowserStack Android e2e testing, pass `--spec path/to/spec` to run a specific test
