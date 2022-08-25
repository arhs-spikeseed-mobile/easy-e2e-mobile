const commonBaseConfig =
  require("./wdio.browserstack.common.conf").commonBaseConfig;

exports.baseConfig = {
  ...commonBaseConfig,

  capabilities: [
    {
      project: "Easy E2E Mobile",
      build: "Easy E2E Mobile iOS",
      device: "iPhone 13",
      os_version: "15.5",
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
