import type { StorybookConfig } from "@storybook/react-vite";
import react from "@vitejs/plugin-react";

const config: StorybookConfig = {
  stories: ["../src/**/*.stories.@(js|jsx|ts|tsx)"],
  addons: ["@storybook/addon-links"],
  framework: "@storybook/react-vite",
  viteFinal: (config) => ({
    ...config,
    plugins: [...(config.plugins ?? []), react()],
  }),
};

export default config;
