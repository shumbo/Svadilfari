import React from "react";
import { Decorator } from "@storybook/react-vite";

import { i18n } from "../i18n";

export const i18nDecorator: Decorator = (Story) => {
  i18n();
  return <Story />;
};
