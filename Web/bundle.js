const esbuild = require("esbuild");

esbuild.build({
  entryPoints: ["src/content/content.ts"],
  bundle: true,
  outfile: "../SvadilfariExtension/Resources/content.js",
  watch: !!process.env["watch"],
});

esbuild.build({
  entryPoints: ["src/background.ts"],
  bundle: true,
  outfile: "../SvadilfariExtension/Resources/background.js",
  watch: !!process.env["watch"],
});
