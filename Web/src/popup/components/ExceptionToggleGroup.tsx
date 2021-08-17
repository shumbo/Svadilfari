import { Box, Heading, VStack } from "@chakra-ui/react";
import React, { VFC } from "react";
import { ExceptionToggle } from "./ExceptionToggle";

export type ExceptionStatus = {
  /**
   * true if Svadilfari is disabled on this domain
   */
  disabledDomain: boolean;
  /**
   * true if Svadilfari is disabled on this page
   */
  disabledPage: boolean;
};

export type ExceptionToggleGroupProps = {
  domain: string;
  path: string;
  value: ExceptionStatus;
  onChange: (newValue: Partial<ExceptionStatus>) => void;
};

export const ExceptionToggleGroup: VFC<ExceptionToggleGroupProps> = ({
  domain,
  path,
  value,
  onChange,
}) => {
  return (
    <VStack align="stretch" padding={4}>
      <Heading size="xs" color="gray.500">
        DISABLE GESTURES ON
      </Heading>
      <ExceptionToggle
        title="This website:"
        description={domain}
        onChange={(b) => {
          onChange({ disabledDomain: b });
        }}
        value={value.disabledDomain}
      />
      <Box paddingLeft={2} borderLeftColor="gray.200" borderLeftWidth={4}>
        <ExceptionToggle
          title="This page:"
          description={path}
          isDisabled={value.disabledDomain}
          onChange={(b) => {
            onChange({ disabledPage: b });
          }}
          value={value.disabledPage}
        />
      </Box>
    </VStack>
  );
};
