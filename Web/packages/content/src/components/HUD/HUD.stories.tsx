import React from "react";
import { ComponentMeta, Story } from "@storybook/react";
import { HUD, HUDProps } from "./HUD";
import AddIcon from "@fluentui/svg-icons/icons/tab_add_20_regular.svg";

const meta: ComponentMeta<typeof HUD> = {
  title: "HUD",
  component: HUD,
  parameters: {
    backgrounds: {
      default: "Big Sur",
    },
    layout: "centered",
  },
  args: {
    title: "New Tab",
    message: "Create a New Tab",
    icon: AddIcon,
  },
};

export default meta;

const Template: Story<HUDProps> = (args) => <HUD {...args} />;

export const Preview = Template.bind({});
Preview.args = {
  visible: true,
};

export const TitleOnly = Template.bind({});
TitleOnly.args = {
  visible: true,
  message: undefined,
  icon: undefined,
};

export const Success = Template.bind({});
Success.args = {
  visible: false,
  cancel: false,
};

export const Cancel = Template.bind({});
Cancel.args = {
  visible: false,
  cancel: true,
};

export const AppStoreJa = Template.bind({});
