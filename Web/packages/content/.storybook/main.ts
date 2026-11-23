import type { StorybookConfig } from "@storybook/react-vite";
import { vanillaExtractPlugin } from "@vanilla-extract/vite-plugin";
import react from "@vitejs/plugin-react";
import svgr from "vite-plugin-svgr";

const config: StorybookConfig = {
  stories: ["../src/**/*.stories.@(js|jsx|ts|tsx)"],
  addons: ["@storybook/addon-links"],
  framework: "@storybook/react-vite",
  // Match the esbuild build (webextension-toolkit): every *.svg import is a React component.
  viteFinal: (config) => ({
    ...config,
    plugins: [
      ...(config.plugins ?? []),
      react(),
      vanillaExtractPlugin(),
      svgr({ include: "**/*.svg", svgrOptions: { icon: true } }),
    ],
  }),
};

export default config;
