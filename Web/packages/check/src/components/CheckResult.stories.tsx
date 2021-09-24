import React from "react";
import { ComponentMeta, Story } from "@storybook/react";
import { CheckResult, CheckResultProps } from "./CheckResult";
import { chakraDecorator } from "../../../../../WebExtension/src/popup/utils/ChakraDecorator";
import { i18nDecorator } from "../utils/I18nDecorator";

const meta: ComponentMeta<typeof CheckResult> = {
  title: "checker/CheckResult",
  component: CheckResult,
  decorators: [chakraDecorator, i18nDecorator],
};
export default meta;

const Template: Story<CheckResultProps> = (args) => <CheckResult {...args} />;

export const Loading = Template.bind({});
Loading.args = { status: null };

export const Active = Template.bind({});
Active.args = { status: "ACTIVE" };

export const Inactive = Template.bind({});
Inactive.args = { status: "INACTIVE" };
