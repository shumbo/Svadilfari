import React from "react";
import { Meta, StoryFn } from "@storybook/react-vite";
import AddIcon from "@fluentui/svg-icons/icons/tab_add_20_regular.svg";

import { HUD, HUDProps } from "./HUD";

const meta: Meta<typeof HUD> = {
  title: "HUD",
  component: HUD,
  parameters: {
    layout: "centered",
  },
  globals: {
    backgrounds: { value: "bigSur" },
  },
  args: {
    title: "New Tab",
    message: "Create a New Tab",
    icon: AddIcon,
  },
};

export default meta;

const Template: StoryFn<HUDProps> = (args) => <HUD {...args} />;

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
