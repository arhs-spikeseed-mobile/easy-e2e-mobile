const commonBaseConfig =
  require("./wdio.browserstack.common.conf").commonBaseConfig;

exports.baseConfig = {
  ...commonBaseConfig,

  capabilities: [
    {
      project: "Easy E2E Mobile",
      build: "Easy E2E Mobile Android",
      deviceName: "Google Pixel 6",
      platformName: "android",
      platformVersion: "12.0",
      app: process.env.BS_PATH,
      "browserstack.debug": true,
      "browserstack.networkLogs": true,
      "browserstack.appium_version": "1.22.0",
      "browserstack.midSessionInstallApps": [process.env.BS_PATH],
      "browserstack.timezone": "Brussels",
      "browserstack.idleTimeout": "300",
    },
  ],
};
