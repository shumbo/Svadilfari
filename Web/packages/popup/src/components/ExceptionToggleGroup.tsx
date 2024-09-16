import { Box, Heading, VStack } from "@chakra-ui/react";
import React, { useMemo, FC } from "react";
import { Browser } from "webextension-typedef";

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
  i18n: Browser.I18n.Static;
  domain: string;
  path: string;
  value: ExceptionStatus;
  onChange: (newValue: Partial<ExceptionStatus>) => void;
};

export const ExceptionToggleGroup: FC<ExceptionToggleGroupProps> = ({
  i18n,
  domain,
  path,
  value,
  onChange,
}) => {
  return (
    <VStack align="stretch" padding={4}>
      <Heading size="xs" color="gray.500">
        {useMemo(
          () => i18n.getMessage("exception_toggle_group:disable_gestures_on"),
          [i18n],
        )}
      </Heading>
      <ExceptionToggle
        title={useMemo(
          () => i18n.getMessage("exception_toggle_group:this_domain"),
          [i18n],
        )}
        description={domain}
        onChange={(b) => {
          onChange({ disabledDomain: b });
        }}
        value={value.disabledDomain}
      />
      <Box paddingLeft={2} borderLeftColor="gray.200" borderLeftWidth={4}>
        <ExceptionToggle
          title={useMemo(
            () => i18n.getMessage("exception_toggle_group:this_page"),
            [i18n],
          )}
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
