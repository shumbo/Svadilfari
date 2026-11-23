import type { Preview } from "@storybook/react-vite";

import "../src/styles/ios.css";

const preview: Preview = {
  parameters: {
    // Let the iOS grouped background from ios.css show through.
    backgrounds: { disabled: true },
  },
};

export default preview;
