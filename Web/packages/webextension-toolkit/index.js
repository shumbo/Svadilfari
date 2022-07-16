const path = require("path");
const esbuild = require("esbuild");
const svgrPlugin = require("esbuild-plugin-svgr");

const argv = require("minimist")(process.argv.slice(2));

/**
 * @typedef BuildWebExtensionOptions
 * @type {object}
 * @property {string} entryPoint - An entry point file
 * @property {string} outfile - An output file
 * @property {boolean | undefined} watch - True to watch for changes
 * @property {string | undefined} globalName - globalName
 * @property {esbuild.Plugin[] | undefined} plugins - additional plugins
 */

/**
 * A esbuild wrapper for WebExtension scripts
 * @param {BuildWebExtensionOptions} options
 */
function buildWebExtension(options) {
  esbuild.build({
    entryPoints: [options.entryPoint],
    bundle: true,
    target: ["safari15"],
    outfile: options.outfile,
    minify: argv["minify"],
    pure: argv["minify"] && ["console.log"],
    watch: options.watch ?? argv["watch"],
    logLevel: "info",
    plugins: [svgrPlugin({ icon: true }), ...(options.plugins ?? [])],
    globalName: options.globalName,
  });
}

/**
 * @returns {string} A path of the app root
 */
function getAppRoot() {
  return path.resolve(__dirname, "../../../Svadilfari");
}

/**
 * @returns {string} A path of the extension root
 */
function getExtensionRoot() {
  return path.resolve(__dirname, "../../../SvadilfariExtension");
}

module.exports = { buildWebExtension, getAppRoot, getExtensionRoot };
