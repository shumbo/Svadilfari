import React from "react";
import { Meta, StoryFn } from "@storybook/react-vite";

import { i18nDecorator } from "../utils/I18nDecorator";

import { CheckResult, CheckResultProps } from "./CheckResult";

const meta: Meta<typeof CheckResult> = {
  title: "checker/CheckResult",
  component: CheckResult,
  decorators: [i18nDecorator],
};
export default meta;

const Template: StoryFn<CheckResultProps> = (args) => <CheckResult {...args} />;

export const Loading = Template.bind({});
Loading.args = { status: null };

export const Active = Template.bind({});
Active.args = { status: "ACTIVE" };

export const Inactive = Template.bind({});
Inactive.args = { status: "INACTIVE" };

export const Unsupported = Template.bind({});
Unsupported.args = { status: "UNSUPPORTED" };
