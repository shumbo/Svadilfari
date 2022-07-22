import React from "react";
import { ComponentMeta, Story } from "@storybook/react";
import { MockI18n } from "mock";

import { chakraDecorator } from "../utils/ChakraDecorator";

import {
  ExceptionToggleGroup,
  ExceptionToggleGroupProps,
} from "./ExceptionToggleGroup";

const meta: ComponentMeta<typeof ExceptionToggleGroup> = {
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

const Template: Story<ExceptionToggleGroupProps> = (args) => (
  <ExceptionToggleGroup {...args} />
);

export const Default = Template.bind({});
Default.args = {};

export const Long = Template.bind({});
Long.args = {
  domain: "longlonglonglonglonglonglonglong.example.com",
  path: "/longlonglonglonglonglonglonglonglonglonglonglonglonglonglonglong",
};
