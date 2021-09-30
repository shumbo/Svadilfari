const path = require("path");
const { buildWebExtension, getExtensionRoot } = require("webextension-toolkit");

buildWebExtension({
  entryPoint: "./src/popup.tsx",
  outfile: path.join(getExtensionRoot(), "Resources/popup.js"),
});
