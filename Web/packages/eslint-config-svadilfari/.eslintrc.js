/*eslint-env node */
module.exports = {
  parser: "@typescript-eslint/parser",
  plugins: ["@typescript-eslint", "react"],
  extends: [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended",
    "plugin:react/recommended",
    "plugin:react-hooks/recommended",
    "plugin:import/errors",
    "plugin:import/warnings",
    "plugin:import/typescript",
    "prettier",
  ],
  rules: {
    "react/prop-types": ["off"],
    "react/react-in-jsx-scope": ["off"],
    "import/order": ["error", { "newlines-between": "always" }],
    "import/namespace": ["off"],
    "@typescript-eslint/no-unused-vars": [
      1,
      { varsIgnorePattern: "^_", argsIgnorePattern: "^_" },
    ],
  },
};
