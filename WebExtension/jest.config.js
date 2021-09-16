/** @type {import('ts-jest/dist/types').InitialOptionsTsJest} */
module.exports = config = {
  testEnvironment: "node",
  preset: "ts-jest",
  globals: {
    "ts-jest": {
      isolatedModules: true,
    },
  },
  moduleNameMapper: {
    "\\.svg": "<rootDir>/src/__mocks__/svgr.ts",
  },
};
