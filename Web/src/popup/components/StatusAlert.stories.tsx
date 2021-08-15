import React from "react";
import { ComponentMeta, Story } from "@storybook/react";
import { StatusAlert, StatusAlertProps } from "./StatusAlert";
import { chakraDecorator } from "../utils/ChakraDecorator";

const meta: ComponentMeta<typeof StatusAlert> = {
  title: "Popup/StatusAlert",
  component: StatusAlert,
  decorators: [chakraDecorator],
};

export default meta;

const Template: Story<StatusAlertProps> = (args) => <StatusAlert {...args} />;

export const Active = Template.bind({});
Active.args = {
  status: "ACTIVE",
};

export const Inactive = Template.bind({});
Inactive.args = {
  status: "INACTIVE",
};
