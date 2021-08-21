import React from "react";
import { Meta } from "@storybook/react";
import { DebugContentMessenger } from "../messenger/ContentMessanger";
import { ContentApp } from "./ContentApp";

const meta: Meta = {
  title: "debugger",
  parameters: {
    backgrounds: {
      default: "Big Sur",
    },
    layout: "centered",
  },
};

export default meta;

const Template = () => <ContentApp messenger={new DebugContentMessenger()} />;

export const Debugger = Template.bind({});
