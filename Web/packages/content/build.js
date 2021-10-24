const path = require("path");
const { buildWebExtension, getExtensionRoot } = require("webextension-toolkit");
const { vanillaExtractPlugin } = require("@vanilla-extract/esbuild-plugin");

buildWebExtension({
  entryPoint: "./src/content.ts",
  outfile: path.join(getExtensionRoot(), "Resources/content.js"),
  plugins: [vanillaExtractPlugin()],
});
