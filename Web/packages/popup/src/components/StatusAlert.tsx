import { Alert, AlertIcon } from "@chakra-ui/react";
import React, { useMemo, FC } from "react";
import { Browser } from "webextension-typedef";

export type StatusAlertProps = {
  i18n: Browser.I18n.Static;
  status: "ACTIVE" | "INACTIVE" | null;
};

export const StatusAlert: FC<StatusAlertProps> = ({ i18n, status }) => {
  const activeMsg = useMemo(
    () => i18n.getMessage("status_alert:active"),
    [i18n],
  );
  const inactiveMsg = useMemo(
    () => i18n.getMessage("status_alert:inactive"),
    [i18n],
  );
  if (status === "ACTIVE") {
    return (
      <Alert variant="left-accent" status="success">
        <AlertIcon />
        {activeMsg}
      </Alert>
    );
  }
  if (status === "INACTIVE") {
    return (
      <Alert variant="left-accent" status="warning">
        <AlertIcon />
        {inactiveMsg}
      </Alert>
    );
  }
  return null;
};
