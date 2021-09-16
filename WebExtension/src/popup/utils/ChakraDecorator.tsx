import React from "react";
import { ChakraProvider } from "@chakra-ui/react";
import { DecoratorFn } from "@storybook/react";

export const chakraDecorator: DecoratorFn = (Story) => (
  <ChakraProvider>
    <Story />
  </ChakraProvider>
);
