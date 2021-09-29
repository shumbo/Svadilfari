import React from "react";
import { Meta } from "@storybook/react";
import { ContentApp } from "./ContentApp";
import { MockI18n, mockTabsInstance } from "mock";
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
  <ContentApp
    messenger={new DebugContentMessenger()}
    i18n={new MockI18n()}
    tabs={mockTabsInstance}
  />
);

export const Debugger = Template.bind({});
