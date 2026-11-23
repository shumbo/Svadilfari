import { defineConfig } from "vitest/config";

// Each package is an inline project so Vitest does not load package-level
// Vite configs (e.g. `check` still pins Vite 5 for Storybook 7).
const packages = ["background", "check", "content", "core", "go"];

export default defineConfig({
  test: {
    projects: packages.map((name) => ({
      root: `packages/${name}`,
      test: { name, environment: "node" },
    })),
  },
});
