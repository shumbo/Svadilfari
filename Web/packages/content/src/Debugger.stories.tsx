import React from "react";
import { Meta } from "@storybook/react";
import { MockI18n } from "mock";

import { ContentApp } from "./ContentApp";
import { DebugContentMessenger } from "./ContentMessenger";

const meta: Meta = {
  title: "Content/Debugger",
  parameters: {
    backgrounds: {
      default: "Big Sur",
    },
    layout: "centered",
  },
};

export default meta;

const Template = () => (
  <ContentApp messenger={new DebugContentMessenger()} i18n={new MockI18n()} />
);

export const Debugger = Template.bind({});
