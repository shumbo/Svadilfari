const esbuild = require("esbuild");
const svgrPlugin = require("esbuild-plugin-svgr");

esbuild.build({
  entryPoints: ["src/content/content.ts"],
  bundle: true,
  outfile: "../SvadilfariExtension/Resources/content.js",
  plugins: [svgrPlugin({ icon: true })],
  watch: !!process.env["watch"],
});

esbuild.build({
  entryPoints: ["src/background/background.ts"],
  bundle: true,
  outfile: "../SvadilfariExtension/Resources/background.js",
  watch: !!process.env["watch"],
});

esbuild.build({
  entryPoints: ["src/popup/popup.tsx"],
  bundle: true,
  outfile: "../SvadilfariExtension/Resources/popup.js",
  watch: !!process.env["watch"],
});

esbuild.build({
  entryPoints: ["src/NativeHelper/NativeHelper.ts"],
  bundle: true,
  globalName: "S",
  outfile: "../Svadilfari/Resources/NativeHelper.js",
  watch: !!process.env["watch"],
});
