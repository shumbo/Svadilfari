import { existsSync, readdirSync } from "node:fs";
import { defineConfig } from "vitest/config";

// Every workspace package is its own inline project, so a test added to any
// package is picked up without editing this file. Inline projects (rather
// than per-package configs) also keep Vitest from loading package-level Vite
// configs and their plugins (e.g. `check/vite.config.ts`), which tests don't
// need.
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
