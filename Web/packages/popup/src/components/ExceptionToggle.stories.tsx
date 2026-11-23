import { Meta, StoryFn } from "@storybook/react-vite";
import React from "react";

import { ExceptionToggle, ExceptionToggleProps } from "./ExceptionToggle";

const meta: Meta<typeof ExceptionToggle> = {
  title: "Popup/ExceptionToggle",
  component: ExceptionToggle,
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
  value: false,
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
