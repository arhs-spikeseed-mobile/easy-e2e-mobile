const path = require("path");

module.exports = {
  compilerOptions: {
    outDir: "./.build/",
    sourceMap: false,
    target: "es2019",
    module: "commonjs",
    removeComments: true,
    noImplicitAny: true,
    strictPropertyInitialization: true,
    strictNullChecks: true,
    allowJs: true,
    types: ["node", "webdriverio/async", "@wdio/mocha-framework"],
  },
  include: [
    path.join(process.env.E2E_SPECS_PATH, process.env.E2E_SPECS_PATTERN),
    "./e2ehelpers.ts",
  ],
};
