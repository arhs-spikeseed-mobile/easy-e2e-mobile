const baseConfig =
  require("../lib/baseConfigs/wdio.browserstack.ios.conf").baseConfig;

// Add your custom configurations here
exports.config = {
  ...baseConfig,
};
