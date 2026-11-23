import React from "react";
import { ChakraProvider } from "@chakra-ui/react";
import { Decorator } from "@storybook/react-vite";

export const chakraDecorator: Decorator = (Story) => (
  <ChakraProvider>
    <Story />
  </ChakraProvider>
);
