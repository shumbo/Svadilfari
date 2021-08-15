import { Alert, AlertIcon } from "@chakra-ui/react";
import React, { VFC } from "react";

export type StatusAlertProps = {
  status: "ACTIVE" | "INACTIVE" | null;
};

export const StatusAlert: VFC<StatusAlertProps> = ({ status }) => {
  if (status === "ACTIVE") {
    return (
      <Alert variant="left-accent" status="success">
        <AlertIcon />
        Svadilfari is active! Draw gestures for smooth browsing!
      </Alert>
    );
  }
  if (status === "INACTIVE") {
    return (
      <Alert variant="left-accent" status="warning">
        <AlertIcon />
        Svadilfari is not active on this page.
      </Alert>
    );
  }
  return null;
};
