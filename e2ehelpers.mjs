export async function wait(seconds = 10 * 1000) {
  await new Promise((r) => setTimeout(r, seconds));
}

export async function relaunchApp() {
  if (driver.capabilities.buildName) {
    // iOS (Browserstack)
    await driver.removeApp(process.env.IOS_BUNDLE_ID);
    await driver.installApp(process.env.BS_PATH);
    await driver.launchApp();
  } else {
    await driver.reset();
  }
  await wait(20 * 1000);
}
