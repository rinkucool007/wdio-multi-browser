import type { Options } from "@wdio/types";
import allure from "@wdio/allure-reporter";
import dotenv from "dotenv";
dotenv.config();

export const config: Options.Testrunner = {
  runner: 'local',
  specs: [ './test/features/**/*.feature' ],
  exclude: [],
  maxInstances: 10,
  capabilities: [
      {
          browserName: "chrome",
          acceptInsecureCerts: true,
          "goog:chromeOptions": {
              args: [
                  "--headless",
                  "--no-sandbox",
                  "--disable-gpu",
                  "--window-size=1440, 2560",
                  "--disable-dev-shm-usage",
                  "--ignore-certificate-errors"
              ],
              prefs: {
                  "profile.managed_default_content_settings.popups": 1,
                  "profile.managed_default_content_settings.notifications": 1,
              },
          }
      },
      {
        browserName: "MicrosoftEdge",
        'ms:edgeOptions': {
            args: [
                "--headless",
                "--no-sandbox"
            ],
        }
    },      
  ],

  logLevel: "info",

  bail: 0,
  baseUrl: "http://localhost",
  waitforTimeout: 10000,
  connectionRetryTimeout: 120000,
  connectionRetryCount: 3,
  services: ["chromedriver"],
  framework: "cucumber",
  reporters: [
    "spec",
    [
      "allure",
      {
        outputDir: "allure-results",
        disableWebdriverStepsReporting: true,
        useCucumberStepReporter: true,
      },
    ],
  ],

  cucumberOpts: {
    require: ["./test/features/step-definations/*.ts"],
    backtrace: false,
    requireModule: [],
    dryRun: false,
    failFast: false,
    snippets: true,
    source: true,
    strict: false,
    tagExpression: "@demo",
    timeout: 600000,
    ignoreUndefinedDefinitions: false,
  },

  afterStep: async function (step, scenario, result, context) {
    // Take screenshot if failed
    if (!result.passed) {
      await browser.takeScreenshot();
    }
  },
};
