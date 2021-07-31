// vite.config.js
const { resolve } = require("path");

module.exports = {
  build: {
    rollupOptions: {
      input: {
        content: resolve(__dirname, "src/debugger/content/index.html"),
      },
    },
  },
};
