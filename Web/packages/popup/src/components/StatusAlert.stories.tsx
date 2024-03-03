import React from "react";
import { Meta, StoryFn } from "@storybook/react";
import { MockI18n } from "mock";

import { chakraDecorator } from "../utils/ChakraDecorator";

import { StatusAlert, StatusAlertProps } from "./StatusAlert";

const meta: Meta<typeof StatusAlert> = {
  title: "Popup/StatusAlert",
  component: StatusAlert,
  decorators: [chakraDecorator],
  args: {
    i18n: new MockI18n(),
  },
};

export default meta;

const Template: StoryFn<StatusAlertProps> = (args) => <StatusAlert {...args} />;

export const Active = Template.bind({});
Active.args = {
  status: "ACTIVE",
};

export const Inactive = Template.bind({});
Inactive.args = {
  status: "INACTIVE",
};
