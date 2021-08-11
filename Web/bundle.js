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
  entryPoints: ["src/background.ts"],
  bundle: true,
  outfile: "../SvadilfariExtension/Resources/background.js",
  watch: !!process.env["watch"],
});
