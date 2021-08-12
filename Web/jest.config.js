module.exports = {
  testEnvironment: "node",
  transform: {
    "^.+\\.tsx?$": "esbuild-jest",
  },
  moduleNameMapper: {
    "\\.svg": "<rootDir>/src/__mocks__/svgr.ts",
  },
};
