const path = require("path");

exports.commonBaseConfig = {
  user: process.env.BS_USER,
  key: process.env.BS_KEY,

  updateJob: false,
  specs: [path.join(".build", process.env.E2E_SPECS_PATTERN)],
  exclude: [],
  logLevel: "info",
  coloredLogs: true,
  screenshotPath: "./errorShots/",
  baseUrl: "",
  waitforTimeout: 60000,
  connectionRetryTimeout: 300000,
  connectionRetryCount: 3,

  framework: "mocha",
  mochaOpts: {
    ui: "bdd",
    timeout: 40000,
  },

  maxInstances: 1,

  autoCompileOpts: {
    autoCompile: false,
  },

  beforeTest: function (test, context) {
    console.log("Running " + test.title + " ...");
    var rtitle = context._runnable.parent.title.split('"').join("'");
    browser.executeScript(
      'browserstack_executor: {"action": "setSessionName", "arguments": {"name":"' +
        rtitle +
        '"}}',
      []
    );
  },
  afterTest: function (
    test,
    context,
    { error, result, duration, passed, retries }
  ) {
    //keep it for debug
    //console.log('\t', '--> [test]:', test);
    //console.log('\t', '--> [result]:', result);
    //console.log('\t', '--> [error]:', error);
    //console.log('\t', '--> [context]:', context);
    //console.log('\t', '--> [test.title]:', test.title);
    var lresult = "failed";
    var message = "OK";
    if (test.passed == true) {
      lresult = "passed";
      console.log("\t", `${test.title} --> [STATUS]:`, `✅ PASSED`);
    } else {
      // catch ugly error when we reinstall the app
      if (error == undefined) {
        console.log(
          "\t",
          `${test.title} -->  CATCH UGLY ERROR WHEN WE REINSTALL THE APP`
        );
        return;
      }
      console.log("\t", `${test.title} --> [STATUS]:`, `🚨 FAILED`);
      message = error.toString().split('"').join("'");
    }
    browser.executeScript(
      'browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"' +
        lresult +
        '","reason": "' +
        message +
        '"}}',
      []
    );
  },
};
