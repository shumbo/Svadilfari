const path = require("path");
const { buildWebExtension, getExtensionRoot } = require("webextension-toolkit");

buildWebExtension({
  entryPoint: "./src/index.ts",
  outfile: path.join(getExtensionRoot(), "Resources/background.js"),
});
