const path = require("path");
const esbuild = require("esbuild");
const svgrPlugin = require("esbuild-plugin-svgr");

const appRoot = path.resolve(__dirname, "../Svadilfari");
const extensionRoot = path.resolve(__dirname, "../SvadilfariExtension");

const watch = !!process.env["watch"];
const watchConfig = {
  watch,
  logLevel: watch ? "info" : "warning",
};

// content
esbuild.build({
  entryPoints: ["src/content/content.ts"],
  bundle: true,
  outfile: path.join(extensionRoot, "Resources/content.js"),
  plugins: [svgrPlugin({ icon: true })],
  ...watchConfig,
});

// background
esbuild.build({
  entryPoints: ["src/background/background.ts"],
  bundle: true,
  outfile: path.join(extensionRoot, "Resources/background.js"),
  ...watchConfig,
});

// popup
esbuild.build({
  entryPoints: ["src/popup/popup.tsx"],
  bundle: true,
  outfile: path.join(extensionRoot, "Resources/popup.js"),
  ...watchConfig,
});

// native helper
esbuild.build({
  entryPoints: ["src/NativeHelper/NativeHelper.ts"],
  bundle: true,
  globalName: "S",
  outfile: path.join(appRoot, "Resources/NativeHelper.js"),
  ...watchConfig,
});
