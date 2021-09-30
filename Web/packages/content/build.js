const path = require("path");
const { buildWebExtension, getExtensionRoot } = require("webextension-toolkit");

buildWebExtension({
  entryPoint: "./src/content.ts",
  outfile: path.join(getExtensionRoot(), "Resources/content.js"),
});
