import React from "react";
import { DecoratorFn } from "@storybook/react";
import { i18n } from "../i18n";

export const i18nDecorator: DecoratorFn = (Story) => {
  i18n();
  return <Story />;
};
