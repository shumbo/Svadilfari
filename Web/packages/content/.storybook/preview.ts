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
          value: [
            "radial-gradient(ellipse at 20% 80%, #f9a26c 0%, transparent 55%)",
            "radial-gradient(ellipse at 80% 70%, #e0569b 0%, transparent 50%)",
            "radial-gradient(ellipse at 60% 20%, #5b7bd6 0%, transparent 60%)",
            "linear-gradient(160deg, #1d2b64 0%, #7b3f8c 50%, #f8b26a 100%)",
          ].join(", "),
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
