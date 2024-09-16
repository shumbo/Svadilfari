/* eslint-env node */
import { join } from "path";

import { buildWebExtension, getExtensionRoot } from "webextension-toolkit";

buildWebExtension({
  entryPoint: "./src/index.ts",
  outfile: join(getExtensionRoot(), "Resources/background.js"),
});
