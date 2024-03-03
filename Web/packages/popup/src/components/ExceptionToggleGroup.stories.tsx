import React from "react";
import { Meta, StoryFn } from "@storybook/react";
import { MockI18n } from "mock";

import { chakraDecorator } from "../utils/ChakraDecorator";

import {
  ExceptionToggleGroup,
  ExceptionToggleGroupProps,
} from "./ExceptionToggleGroup";

const meta: Meta<typeof ExceptionToggleGroup> = {
  title: "Popup/ExceptionToggleGroup",
  component: ExceptionToggleGroup,
  decorators: [chakraDecorator],
  args: {
    i18n: new MockI18n(),
    value: {
      disabledDomain: false,
      disabledPage: false,
    },
    domain: "example.com",
    path: "/foo",
  },
  parameters: {
    layout: "fullscreen",
  },
};

export default meta;

const Template: StoryFn<ExceptionToggleGroupProps> = (args) => (
  <ExceptionToggleGroup {...args} />
);

export const Default = Template.bind({});
Default.args = {};

export const Long = Template.bind({});
Long.args = {
  domain: "longlonglonglonglonglonglonglong.example.com",
  path: "/longlonglonglonglonglonglonglonglonglonglonglonglonglonglonglong",
};
