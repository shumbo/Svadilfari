import type { Preview } from "@storybook/react-vite";

import "../src/styles/ios.css";

const preview: Preview = {
  parameters: {
    layout: "fullscreen",
    backgrounds: { disabled: true },
  },
};

export default preview;
