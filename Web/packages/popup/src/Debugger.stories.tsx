import React from "react";
import { Meta, StoryFn } from "@storybook/react";
import { MockI18n } from "mock";

import { PopupApp, PopupAppProps } from "./PopupApp";
import { DebugPopupMessenger } from "./PopupMessenger";
import { DebugPopupTabManager } from "./PopupTabManager";

const meta: Meta<typeof PopupApp> = {
  title: "Popup/Debugger",
  args: {
    i18n: new MockI18n(),
    messenger: new DebugPopupMessenger(),
    tabManager: new DebugPopupTabManager(),
  },
  parameters: {
    layout: "fullscreen",
  },
};

export default meta;

const Template: StoryFn<PopupAppProps> = (args) => <PopupApp {...args} />;

export const Enabled = Template.bind({});

export const DisabledDomain = Template.bind({});
DisabledDomain.args = {
  messenger: new DebugPopupMessenger("example.com"),
};

export const DisabledPage = Template.bind({});
DisabledPage.args = {
  messenger: new DebugPopupMessenger("example.com", "/"),
};
