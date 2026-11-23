import type { Preview } from "@storybook/react-vite";

import "../src/styles/ios.css";

const preview: Preview = {
  parameters: {
    backgrounds: { disabled: true },
  },
};

export default preview;
