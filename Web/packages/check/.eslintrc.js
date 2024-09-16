module.exports = {
  root: true,
  extends: ["svadilfari", "plugin:storybook/recommended"],
  parserOptions: {
    project: "./tsconfig.json",
  },
  settings: {
    react: {
      version: "detect",
    },
  },
};
