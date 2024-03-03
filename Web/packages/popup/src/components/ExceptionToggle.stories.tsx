import { Meta, StoryFn } from "@storybook/react";
import React from "react";

import { chakraDecorator } from "../utils/ChakraDecorator";

import { ExceptionToggle, ExceptionToggleProps } from "./ExceptionToggle";

const meta: Meta<typeof ExceptionToggle> = {
  title: "Popup/ExceptionToggle",
  component: ExceptionToggle,
  decorators: [chakraDecorator],
};

export default meta;

const Template: StoryFn<ExceptionToggleProps> = (args) => (
  <ExceptionToggle {...args} />
);

export const Checked = Template.bind({});
Checked.args = {
  value: true,
  title: "On this website:",
  description: "example.com",
};

export const Unchecked = Template.bind({});
Unchecked.args = {
  value: true,
  title: "On this page:",
  description: "/foo/bar",
};

export const ReadOnly = Template.bind({});
ReadOnly.args = {
  value: true,
  isDisabled: true,
  title: "On this page:",
  description: "/foo/bar",
};
