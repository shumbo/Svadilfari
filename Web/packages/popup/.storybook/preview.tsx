import React from "react";
import { Decorator } from "@storybook/react-vite";
import { ChakraProvider } from "@chakra-ui/react";

export const decorators: Decorator[] = [
  (Story) => (
    <ChakraProvider>
      <Story />
    </ChakraProvider>
  ),
];
