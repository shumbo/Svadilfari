import React from "react";
import { ComponentMeta, Story } from "@storybook/react";
import { HUD, HUDProps } from "../components/HUD/HUD";
import AddIcon from "@fluentui/svg-icons/icons/tab_add_20_regular.svg";
import { ChakraProvider } from "@chakra-ui/react";

const meta: ComponentMeta<typeof HUD> = {
  title: "AppStore",
  component: HUD,
  parameters: {
    layout: "fullscreen",
  },
  args: {
    title: "New Tab",
    message: "Create a New Tab",
    icon: AddIcon,
  },
};

export default meta;

export const PreviewEn: Story<HUDProps> = () => (
  <ChakraProvider>
    <style>
      {`
      html, body, #root {
        width: 100%;
        height: 100%;
      }
      `}
    </style>
    <iframe
      src="https://en.wikipedia.org/wiki/Gesture"
      style={{ width: "100%", height: "100%" }}
    />
    <HUD title="Open Tab" icon={AddIcon} cancel visible />
  </ChakraProvider>
);

export const PreviewJa: Story<HUDProps> = () => (
  <ChakraProvider>
    <style>
      {`
      html, body, #root {
        width: 100%;
        height: 100%;
      }
      `}
    </style>
    <iframe
      src="https://ja.wikipedia.org/wiki/%E3%82%B8%E3%82%A7%E3%82%B9%E3%83%81%E3%83%A3%E3%83%BC"
      style={{ width: "100%", height: "100%" }}
    />
    <HUD title="新規タブ" icon={AddIcon} cancel visible />
  </ChakraProvider>
);
