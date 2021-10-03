const path = require("path");
const { buildWebExtension, getAppRoot } = require("webextension-toolkit");

buildWebExtension({
  entryPoint: "./src/index.ts",
  outfile: path.join(getAppRoot(), "Resources/NativeHelper.js"),
  globalName: "S",
});
