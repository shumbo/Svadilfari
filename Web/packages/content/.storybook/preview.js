import "modern-css-reset/dist/reset.min.css";

export const parameters = {
  actions: { argTypesRegex: "^on[A-Z].*" },
  controls: {
    matchers: {
      color: /(background|color)$/i,
      date: /Date$/,
    },
  },
  backgrounds: {
    values: [
      {
        name: "Big Sur",
        value:
          "url(https://source.unsplash.com/erApmfRX7eo/1600x900); background-size: cover; background-repeat: no-repeat; background-position: center",
      },
      {
        name: "Gradient",
        value: "linear-gradient(to right, #3494e6, #ec6ead)",
      },
    ],
  },
};
