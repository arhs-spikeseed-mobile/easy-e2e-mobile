const commonBaseConfig =
  require("./wdio.browserstack.common.conf").commonBaseConfig;

exports.baseConfig = {
  ...commonBaseConfig,

  capabilities: [
    {
      "bstack:options": {
        projectName: "Easy E2E Mobile",
        buildName: "Easy E2E Mobile Android",
        debug: true,
        networkLogs: true,
        midSessionInstallApps: [process.env.BS_PATH],
        timezone: "Brussels",
        idleTimeout: "300",
        appiumVersion: "1.22.0",
      },
      "appium:platformVersion": "12.0",
      "appium:deviceName": "Google Pixel 6",
      "appium:app": process.env.BS_PATH,
      platformName: "android",
    },
  ],
};
