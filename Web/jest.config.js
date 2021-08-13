module.exports = {
  testEnvironment: "node",
  transform: {
    "^.+\\.tsx?$": ["esbuild-jest", { sourcemap: true }],
  },
  moduleNameMapper: {
    "\\.svg": "<rootDir>/src/__mocks__/svgr.ts",
  },
};
