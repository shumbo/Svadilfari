import React from "react";
import { DecoratorFn } from "@storybook/react";
import { ChakraProvider } from "@chakra-ui/react";

export const decorators: DecoratorFn[] = [
  (Story) => (
    <ChakraProvider>
      <Story />
    </ChakraProvider>
  ),
];
