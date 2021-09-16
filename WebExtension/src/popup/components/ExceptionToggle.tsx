import { Heading, VStack, Text } from "@chakra-ui/layout";
import { Flex, Spacer, Switch } from "@chakra-ui/react";
import React, { VFC } from "react";

export type ExceptionToggleProps = {
  title: string;
  description: string;
  value: boolean;
  isDisabled?: boolean;
  onChange: (newValue: boolean) => void;
};

export const ExceptionToggle: VFC<ExceptionToggleProps> = ({
  title,
  description,
  value,
  isDisabled,
  onChange,
}) => {
  return (
    <Flex paddingY={1} alignItems="center">
      <VStack align="flex-start" flexShrink={1} minWidth={0}>
        <Heading size="sm">{title}</Heading>
        <Text
          textOverflow="ellipsis"
          whiteSpace="nowrap"
          overflow="hidden"
          maxWidth="100%"
        >
          {description}
        </Text>
      </VStack>
      <Spacer />
      <Switch
        isDisabled={isDisabled}
        isChecked={value}
        onChange={(event) => {
          onChange(event.target.checked);
        }}
        size="lg"
      />
    </Flex>
  );
};
