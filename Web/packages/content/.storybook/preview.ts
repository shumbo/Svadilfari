import type { Preview } from "@storybook/react-vite";
import "modern-css-reset/dist/reset.min.css";

const preview: Preview = {
  parameters: {
    actions: { argTypesRegex: "^on[A-Z].*" },
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/,
      },
    },
    backgrounds: {
      options: {
        bigSur: {
          name: "Big Sur",
          value:
            "url(https://source.unsplash.com/erApmfRX7eo/1600x900); background-size: cover; background-repeat: no-repeat; background-position: center",
        },
        gradient: {
          name: "Gradient",
          value: "linear-gradient(to right, #3494e6, #ec6ead)",
        },
      },
    },
  },
};

export default preview;
