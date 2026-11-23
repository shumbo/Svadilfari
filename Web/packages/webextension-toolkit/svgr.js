const { readFile } = require("node:fs/promises");
const { transform } = require("@svgr/core");

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
