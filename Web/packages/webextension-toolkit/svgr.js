const { readFile } = require("node:fs/promises");
const { transform } = require("@svgr/core");

/**
 * esbuild plugin: `import Icon from "./icon.svg"` yields a React component.
 * @param {import("@svgr/core").Config} [config] svgr options, e.g. `{ icon: true }`
 * @returns {import("esbuild").Plugin}
 */
function svgrPlugin(config = {}) {
  return {
    name: "svgr",
    setup(build) {
      build.onLoad({ filter: /\.svg$/ }, async (args) => {
        const svg = await readFile(args.path, "utf8");
        const contents = await transform(
          svg,
          { ...config, plugins: ["@svgr/plugin-jsx"] },
          { filePath: args.path },
        );
        return { contents, loader: "jsx" };
      });
    },
  };
}

module.exports = { svgrPlugin };
