import { existsSync, readdirSync } from "node:fs";
import { defineConfig } from "vitest/config";

// Inline projects keep Vitest from loading package-level Vite configs.
const packages = readdirSync("packages").filter((name) =>
  existsSync(`packages/${name}/package.json`),
);

export default defineConfig({
  test: {
    projects: packages.map((name) => ({
      root: `packages/${name}`,
      test: { name, environment: "node" },
    })),
  },
});
