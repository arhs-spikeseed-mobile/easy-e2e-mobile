const baseConfig =
  require("../lib/baseConfigs/wdio.browserstack.android.conf").baseConfig;

// Add your custom configurations here
exports.config = {
  ...baseConfig,
};
